Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUDZQfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUDZQfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUDZQfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:35:42 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:38405 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S262954AbUDZQfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:35:40 -0400
Date: Mon, 26 Apr 2004 18:35:39 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Anyone got aic7xxx working with 2.4.26?
Message-ID: <20040426163539.GC13183@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404261532.37860.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404261532.37860.dj@david-web.co.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 03:32:37PM +0100, David Johnson wrote:

> I was wondering if anyone had aic7xxx SCSI working with kernel 2.4.26?

Yep, no problems at all. Upgraded this weekend from 2.4.23 to 2.4.26, and
it Just Worked(tm):

SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 15 for device 00:09.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 19160B Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0200
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0200
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi0:A:6:0: Tagged Queuing enabled.  Depth 64
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
SCSI device sda: 17930694 512-byte hdwr sectors (9181 MB)
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
SCSI device sdb: 17930694 512-byte hdwr sectors (9181 MB)
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 >

-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance." - Q308417
