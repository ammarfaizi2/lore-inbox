Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbTFLKWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbTFLKWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:22:41 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:39418 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP id S264802AbTFLKWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:22:40 -0400
Date: Thu, 12 Jun 2003 11:36:24 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: lode leroy <lode_leroy@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: how to run linux in a diskimage on NTFS
In-Reply-To: <Sea2-F47ZxNIeA8UJ4E0002e414@hotmail.com>
Message-ID: <Pine.SOL.3.96.1030612113338.99B-100000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have a look at http://www.phatlinux.com/ as they install Linux in a file
on windows (I don't know how they sort out the boot but you can find out
yourself). 

Hope this helps,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

On Thu, 12 Jun 2003, lode leroy wrote:
> I want to run linux on an embedded system that does
> not have a CDROM or FLOPPY, so the only possibility
> is to go over the network.
> 
> The machine is running WinXP, and I would prefer not
> to install a boot manager, or destroy the filesystem,
> which is NTFS.
> 
> Is there a possibility to do the following:
> 
> 1) put the following files on the NTFS partition:
> 	bootsector  (<- don't know how to create this one)
> 	bootmanager (<- don't know what to put here)
> 	kernel image
> 	ramdisk image
> 	disk image
> 2) call the bootsector from NTLDR
> 3) call the bootmanager from the bootsector
> 4) load the kernel and ramdisk image from the bootmanager
> 5) mount the NTFS partition READ-WRITE
> 6) mount the disk image READ-WRITE over the loopback device
> 
> 7) if possible, disable NTFS/WRITE for anything but the disk image.
> 
> 
> Can anyone advise me on which bootmanager to use?
> Can anyone tell me if this is possible?
> 
> -- lode
> 
> ps: please CC me directly
> 
> _________________________________________________________________
> MSN Search, for relevant search results! http://search.msn.be
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


