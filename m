Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275813AbRJFXFs>; Sat, 6 Oct 2001 19:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJFXFi>; Sat, 6 Oct 2001 19:05:38 -0400
Received: from imladris.infradead.org ([194.205.184.45]:48651 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S275813AbRJFXFZ>;
	Sat, 6 Oct 2001 19:05:25 -0400
Date: Sun, 7 Oct 2001 00:05:40 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <davidge@jazzfree.com>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some ext2 errors
In-Reply-To: <20011006121322.B2625@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0110062358590.25149-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike.

 >> First i thought this errors has some relation with kernel 2.4.10
 >> and e2fsprogs, but i switched back to 2.4.9 and again i got this
 >> ext2_check_page error.
 >>
 >> Oct  6 17:11:08 fargo kernel: EXT2-fs error (device ide0(3,1)):
 >> ext2_check_page: bad entry in directory #423505: unaligned directory entry
 >> - offset=0, inode=6517874, rec_len=12655, name_len=48

 > This error caused by below error...

 >> Oct  6 17:11:08 fargo kernel: hda: status error: status=0x58 { DriveReady
 >> SeekComplete DataRequest }

 > I've only seen this myself when I've been messing with hdparm on
 > a ide drive

I see this regularly on one of my systems, and hdparm has never even
been insatalled on that system. If I put the drive in a different
system, the drive reports clean, but whatever drive I put in here
regularly reports that problem.

As far as I can tell, it's a problem with the PSU in the computer in
question, as I can swap ANYTHING else in there, motherboard included,
without the problem going away on that drive, but as soon as I swap
the PSU, the problems vanish - even if I put a PSU with a lower rating
in its place.

 >> Oct  6 17:11:08 fargo kernel: hda: drive not ready for command
 >> Oct  6 17:11:08 fargo kernel: hdb: ATAPI DVD-ROM drive, 512kB Cache
 >> Oct  6 17:11:08 fargo kernel: Uniform CD-ROM driver Revision: 3.12
 >> Oct  6 17:11:09 fargo kernel: VFS: Disk change detected on device
 >> ide0(3,64)
 >>
 >>
 >> Any hints are welcome, thanks.

 > Yeah.  If you can't figure out hdparm, leave it alone.

Who says hdparm has anything to do with it?

Best wishes from Riley.

