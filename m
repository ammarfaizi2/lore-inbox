Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbQLYQFS>; Mon, 25 Dec 2000 11:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLYQFI>; Mon, 25 Dec 2000 11:05:08 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:45072 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131661AbQLYQE7>; Mon, 25 Dec 2000 11:04:59 -0500
Date: Mon, 25 Dec 2000 07:32:39 -0800
To: barryn@pobox.com
Cc: radoni@crosswinds.net, linux-kernel@vger.kernel.org
Subject: Re: Proposal: devfs names ending in %d or %u
Message-ID: <20001225073239.B7568@ferret.phonewave.net>
In-Reply-To: <E14AQT2-0001ud-00@dfw-mmp2.email.verio.net> <200012250702.XAA01122@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200012250702.XAA01122@cx518206-b.irvn1.occa.home.com>; from barryn@cx518206-b.irvn1.occa.home.com on Sun, Dec 24, 2000 at 11:02:39PM -0800
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 24, 2000 at 11:02:39PM -0800, Barry K. Nathan wrote:
> Eric Shattow wrote:
> [snip]
> > when i insert a FAT formatted disc with a PC partition table, the partition
> > i want to mount is part1.  when i insert a HFS formatted disc with a MAC
> > partition table, the partition i want to mount is part4. this is very ugly,
> 
> and it has nothing to do with devfs. Those would be /dev/sda1 (adjust
> device name for IDE instead of SCSI, etc.) and /dev/sda4 without devfs.
> 
> In this case, the problem is that different Zip disks really do have their
> data on different partitions. (If you use enough different disks and
> formatting utilities, it won't even be the same partition for all PC disks
> or all Mac disks, IIRC.) I don't use Zip disks much anymore, although
> there's a similar phenomenon with my SCSI MO drive on my desktop Mac
> (which I recently started using Linux on again).
[snip]

And don't forget that IDE zip drives can be programmed to hide the
partition table altogether from the OS. Supposedly this can be changed
via an ATAPI command to the drive, but I don't think the kernel driver
has any support for this.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
