Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131736AbQKVNmK>; Wed, 22 Nov 2000 08:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKVNlv>; Wed, 22 Nov 2000 08:41:51 -0500
Received: from [209.249.10.20] ([209.249.10.20]:35241 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131736AbQKVNlt>; Wed, 22 Nov 2000 08:41:49 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 22 Nov 2000 05:11:48 -0800
Message-Id: <200011221311.FAA20824@baldur.yggdrasil.com>
To: hch@caldera.de
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@caldera.de> writes:

>Neither there are lots of NULL-initilized fields nor is
>there any reason to add new fields (the pci tables are external
>API, because of MODULE_DEVICE_TABLE).

	PCI ID matching relies on the zeros being filled in for
an empty value in the case of class_mask.  depmod deliberately
includes a format comment at the start of modules.pcimap so that the
structure can be changed in the future.

	However, thanks for your feedback.  I will take it into
consideration.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
