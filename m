Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBWTsV>; Fri, 23 Feb 2001 14:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129438AbRBWTsM>; Fri, 23 Feb 2001 14:48:12 -0500
Received: from [216.184.166.130] ([216.184.166.130]:36700 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S129193AbRBWTr6>; Fri, 23 Feb 2001 14:47:58 -0500
Date: Fri, 23 Feb 2001 11:46:20 +0000 (   )
From: John Heil <kerndev@sc-software.com>
To: Ian Wehrman <ian@wehrman.com>
cc: mhaque@haque.net, adilger@turbolinux.com, linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <20010223131205.A10434@wehrman.com>
Message-ID: <Pine.LNX.3.95.1010223114349.19559A-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Ian Wehrman wrote:

> Date: Fri, 23 Feb 2001 13:12:05 -0600
> From: Ian Wehrman <ian@wehrman.com>
> To: mhaque@haque.net, adilger@turbolinux.com, linux-kernel@vger.kernel.org
> Subject: Re: EXT2-fs error
> 
> Mohammad A. Haque <mhaque@haque.net> wrote:
> > I got the following after compiling/rebooting into 2.4.2 and forcing a
> > fsck.
> > 
> > EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> > #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> > name_len=0
> > EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in directory
> > #508411: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0,
> > name_len=0
> > 
> > Possibly the result of the 'silent' bug in 2.4.1?
> 
> you are not the only one who found this bug. immediately after booting 2.4.2 i
> received dozens of these errors, resulting in _major_ filesystem corruption.

In contrast perhaps, 2.4.1-ac19 seems clean so far in this regard after
having some different but equivalently bad corruption in 2.4.1-final.  


> after a half hour of fsck'ing i managed to bring the machine back into a usable
> state, but there are still many files and directories around the fs that have
> the wrong uid/gid associated with them, as well as incorrect file type,
> permissions, etc. i'm not using any unusual hardware, and haven't had any
> other recent issues like this. let me know if i can provide further information,
> or test patches. 
> 
> thanks,
> ian wehrman 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
kerndev@sc-software.com
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

