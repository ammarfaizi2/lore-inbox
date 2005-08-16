Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVHPVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVHPVrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVHPVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:47:14 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:30473 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S932399AbVHPVrN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:47:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.12.3 boot problem - response to Kevin's questions
Date: Tue, 16 Aug 2005 17:45:54 -0400
Message-ID: <94C8C9E8B25F564F95185BDA64AB05F601FC5D73@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12.3 boot problem - response to Kevin's questions
Thread-Index: AcWhwGN/HBVeg8Y6RxiMhPOm+FZyFwABVPyQADgHCsA=
From: "Srinivasan, Usha" <Usha.Srinivasan@unisys.com>
To: "Keith Mannthey" <kmannth@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Aug 2005 21:45:56.0089 (UTC) FILETIME=[E1C61690:01C5A2AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
Thanks for your quick response. Here are my answers posted to the group:

> The 2.6.11 tree is a kernel.org tree?
Yes. I downloaded it from www.kernel.org/pub/linux/kernel/v2.6

> Are you using LVM or regular partitions?
Regular.

> Do you see the scsi driver find the disks?
Nope, that's the problem. I don't see messages such as:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec aic7899 Ultra160 SCSI adapter>
        aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
nor
Vendor: QUANTUM   Model: ATLAS10K2-TY184L  Rev: DA40
  Type:   Direct-Access                      ANSI SCSI revision: 03


> I work around I use some times is to change my root line in the
> bootloader to root=/dev/(your disk).  Lables can cause confusion.
Tried that but it didn't help. It's just not finding the disks.
Moreover, this works fine for 2.6.11.

> The modules are put into an initrd correct?  You need their
>functinality to boot.
Yep, they're there and I see them loading fine. But, no HBAs/disks are
being found.

It's puzzling & annoying. What has changed from 2.6.11 to 2.6.12.3 with
regards to having scsi_mod, sd_mod and aic7xxx drivers as modules???

usha

