Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbRBVILg>; Thu, 22 Feb 2001 03:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130927AbRBVIL0>; Thu, 22 Feb 2001 03:11:26 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:49654 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S130383AbRBVILQ>; Thu, 22 Feb 2001 03:11:16 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102220810.f1M8ApJ21675@webber.adilger.net>
Subject: Re: EXT2-fs error
In-Reply-To: <Pine.LNX.4.32.0102220159390.1925-100000@viper.haque.net> from "Mohammad
 A. Haque" at "Feb 22, 2001 02:02:16 am"
To: "Mohammad A. Haque" <mhaque@haque.net>
Date: Thu, 22 Feb 2001 01:10:51 -0700 (MST)
CC: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammad A. Haque writes:
> I got the following after compiling/rebooting into 2.4.2 and forcing a
> fsck.

Did fsck complain?  If not, then it is a 2.4.2 kernel/driver bug, possibly
not reading any data from disk (the below errors are generated from a zero
filled directory block).

> EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> name_len=0
> EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> name_len=0

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
