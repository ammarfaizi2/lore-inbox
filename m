Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311615AbSDIVS3>; Tue, 9 Apr 2002 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311618AbSDIVS2>; Tue, 9 Apr 2002 17:18:28 -0400
Received: from [216.196.223.237] ([216.196.223.237]:64137 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S311615AbSDIVS1>;
	Tue, 9 Apr 2002 17:18:27 -0400
Date: Tue, 9 Apr 2002 17:18:27 -0400
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
Message-ID: <20020409171827.A18006@sin.sloth.org>
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <3CB345E4.16CE5C9C@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried that too, mke2fs says:
mke2fs: Device size reported to be zero. Invalid partition specified, or a
partition table wasn't reread after running fdisk, due to a modified
partition being busy and in use. You may need to reboot to re-read your
partition table.

This one time, at band camp, Andrew Morton wrote:
> Geoffrey Gallaway wrote:
> > 
> > ...
> > Originally I started playing with ram disks but when I try to create a new
> > ramdisk with "mke2fs /dev/ram0 16384" mke2fs says:
> > mke2fs: Filesystem larger then apparent filesystem size.
> > Proceed anyway? (y,n) y
> > Warning: could not erase sector 2: Invalid arguement
> > Warning: could not erase sector 0: Attempt to write block from filesystem
> > resulted in short write
> > mke2fs: Invalid arguement zeroing block 16320 at end of filesystem
> 
> Try omitting the `16384' option - let mke2fs work out the
> size.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
