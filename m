Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAPRoK>; Tue, 16 Jan 2001 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRAPRoA>; Tue, 16 Jan 2001 12:44:00 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:61958 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129641AbRAPRnt>; Tue, 16 Jan 2001 12:43:49 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95195@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Bryan Henderson'" <hbryan@us.ibm.com>, linux-kernel@vger.kernel.org,
        Venkatesh Ramamurthy <Venkateshr@ami.com>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 12:39:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From a layering point of view, it makes a lot more sense to
> me for the label (or signature or whatever) for this purpose 
> to be in the partition table than inside the filesystem.  The 
> parts of the system that assign devices their identities already 
> know about that part of the disk.
	[Venkatesh Ramamurthy]  The LILO boot loader and the LILO command
line utility should be changed for this. There are some issues when we have
different set of labels names for file system and partition table. The LILO
command line utility should make use of the disk labels of the file system
and use this for creating the partition disk label name. This is something
like assigning a label for kernel in lilo.conf. Is anybody doing this?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
