Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbUKDXGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUKDXGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUKDWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:36:17 -0500
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:20364 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262471AbUKDWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:18:29 -0500
Date: Thu, 4 Nov 2004 22:18:21 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: linux-os@analogic.com
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system.
In-Reply-To: <Pine.LNX.4.60.0411042216340.5130@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0411042218120.5130@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
 <MPG.1bf47baa1b621da0989706@news.gmane.org> <Pine.LNX.4.61.0411041158010.5193@chaos.analogic.com>
 <Pine.LNX.4.60.0411042216340.5130@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Anton Altaparmakov wrote:

> On Thu, 4 Nov 2004, linux-os wrote:
> > On Thu, 4 Nov 2004, Giuseppe Bilotta wrote:
> > > linux-os wrote:
> > > > 
> > > > Hello anybody maintaining NTFS,
> > > > 
> > > > I can't write to a NTFS file-system.
> > > > 
> > > > /proc/mounts shows it's mounted RW:
> > > > /dev/sdd1 /mnt ntfs
> > > > rw,uid=0,gid=0,fmask=0177,dmask=077,nls=utf8,errors=continue,mft_zone_multiplier=1
> > > > 0 0
> > > > 
> > > > .config shows RW support.
> > > > 
> > > > CONFIG_NTFS_FS=m
> > > > # CONFIG_NTFS_DEBUG is not set
> > > > CONFIG_NTFS_RW=y
> > > > 
> > > > Errno is 1 (Operation not permitted), even though root.
> > > 
> > > What are trying to write? AFAIK, the (new) NTFS module only
> > > allows one kind of writing: overwriting an existing file, as
> > > long as its size doesn't change.
> > 
> > Huh? Are we talking about the same thing? I'm talking about
> > the NTFS that Windows/NT and later versions puts on its
> > file-systems. I use an USB external disk with my M$ Laptop
> > and I have always been able to transfer data to/from
> > my machines using that drive. Now I can't. The drive it
> > writable under M$, but I can't even delete anything
> > (no permission for root) under Linux.
> 
> You must have had it formatted as VFAT in the past.  There is now way you 

s/now/no/

> were writing to an NTFS drive from Linux (unless you were using Captive 
> NTFS or one of the commercially available drivers).
> 
> Best regards,
> 
> 	Anton
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
