Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBEAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBEAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbVBEAnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:43:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:6576 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266122AbVBEAkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:40:22 -0500
Subject: Re: 2.6: USB disk unusable level of data corruption
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>
In-Reply-To: <20050204133726.7ba8944f@localhost.localdomain>
References: <1107519382.1703.7.camel@localhost.localdomain>
	 <20050204133726.7ba8944f@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Feb 2005 19:40:13 -0500
Message-Id: <1107564013.10471.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if it's related, but -
I have been using Maxtor OneTouch USB Drive,so far without problems, but
today after upgrading to FC3 2.6.10-760 kernel I just recieved this in
dmesg

usb 1-1: USB disconnect, address 2
scsi0 (0:0): rejecting I/O to device being removed
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda2, logical block 6352
lost page write due to I/O error on sda2
Aborting journal on device sda2.
journal commit I/O error
scsi0 (0:0): rejecting I/O to device being removed
Buffer I/O error on device sda2, logical block 15859714
lost page write due to I/O error on sda2
ext3_abort called.
EXT3-fs error (device sda2): ext3_journal_start_sb: Detected aborted
journal
Remounting filesystem read-only
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
usb 1-1: new high speed USB device using ehci_hcd and address 5
usb 1-1: device descriptor read/64, error -71
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
  Vendor: Maxtor    Model: OneTouch          Rev: 0201
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 398295040 512-byte hdwr sectors (203927 MB)
sdc: assuming drive cache: write through
SCSI device sdc: 398295040 512-byte hdwr sectors (203927 MB)
sdc: assuming drive cache: write through
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
usb-storage: device scan complete
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
scsi0 (0:0): rejecting I/O to dead device
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is
recommended
EXT3 FS on sdc2, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging
interupts
rip acpi_processor_idle+0x10e/0x274
usb 1-1: USB disconnect, address 5
scsi2 (0:0): rejecting I/O to dead device
Buffer I/O error on device sdc2, logical block 0
lost page write due to I/O error on sdc2
usb 1-1: new high speed USB device using ehci_hcd and address 6
usb 1-1: device descriptor read/64, error -71
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 6
EXT3 FS on sdc2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda2): ext3_readdir: directory #6783511 contains a
hole at offset 0
scsi0 (0:0): rejecting I/O to dead device
EXT3-fs error (device sda2): ext3_readdir: directory #6783511 contains a
hole at offset 0


On Fri, 2005-02-04 at 13:37 -0800, Pete Zaitcev wrote:
> On Fri, 04 Feb 2005 23:16:22 +1100, Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > [...] I have since then had multiple
> > ext3 and ext2 errors: 2.6.8, 2.6.9, 2.6.10 and 2.6.11-rc3 all exhibit
> > the problem within an hour of stress (untarring a fresh kernel tree, cp
> > -al'ing to apply patches repeatedly, my normal workload).
> 
> > I realize "ub" exists, but it doesn't seem to want to deal with a disk
> > device.
> 
> In case your EHCI disconnects devices under load, ub won't help.
> You probably heard my claims that ub helps against certain memory
> pressure related lockups and against problems in the SCSI stack,
> which my even be true. Jury is still out on those and your case
> seems different anyway. Please work with David Brownell on the EHCI
> issues. I applied a few patches of his to the 2.4 which made a difference
> in similar circumstances.
> 
> Good luck,
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

