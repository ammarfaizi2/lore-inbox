Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129709AbRCCTeT>; Sat, 3 Mar 2001 14:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRCCTeK>; Sat, 3 Mar 2001 14:34:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43026 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129699AbRCCTd6>;
	Sat, 3 Mar 2001 14:33:58 -0500
Date: Sat, 3 Mar 2001 20:33:50 +0100
From: Jens Axboe <axboe@suse.de>
To: agrawal@ais.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: lingering loopback bugs?
Message-ID: <20010303203350.M2528@suse.de>
In-Reply-To: <E14Yyrs-0002Wz-00@the-village.bc.nu> <Pine.LNX.4.10.10103031303220.15395-100000@SLASH.REM.CMU.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10103031303220.15395-100000@SLASH.REM.CMU.EDU>; from agrawal@ais.org on Sat, Mar 03, 2001 at 03:16:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03 2001, agrawal@ais.org wrote:
> take2:~# uname -a
> Linux take2 2.4.2-ac8 #2 Fri Mar 2 14:12:44 EST 2001 i686 unknown
> take2:~# losetup -e aes /dev/loop0 /dev/hda12
> Available keysizes (bits): 128 192 256 
> Keysize: 128
> Password :
> take2:~# fsck /dev/loop0
> Parallelizing fsck version 1.19 (13-Jul-2000)
> e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
> /dev/loop0: clean, 9567/488640 files, 132070/977122 blocks
> take2:~# mount /dev/loop0 /mnt
> mount: wrong fs type, bad option, bad superblock on /dev/loop0,
>        or too many mounted file systems
> take2:~# fsck /dev/loop0

BTW, if the before mentioned patch doesn't make it work send me info
about the fs block size.

-- 
Jens Axboe

