Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJFTNM>; Sat, 6 Oct 2001 15:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275527AbRJFTNC>; Sat, 6 Oct 2001 15:13:02 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8945
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275567AbRJFTM6>; Sat, 6 Oct 2001 15:12:58 -0400
Date: Sat, 6 Oct 2001 12:13:22 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: davidge@jazzfree.com
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Some ext2 errors
Message-ID: <20011006121322.B2625@mikef-linux.matchmail.com>
Mail-Followup-To: davidge@jazzfree.com,
	Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110061713130.485-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110061713130.485-100000@fargo>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 05:15:22PM +0200, davidge@jazzfree.com wrote:
> 
> Hi,
> 
> First i thought this errors has some relation with kernel 2.4.10 and
> e2fsprogs, but i switched back to 2.4.9 and again i got this
> ext2_check_page error.
> 
> Oct  6 17:11:08 fargo kernel: EXT2-fs error (device ide0(3,1)):
> ext2_check_page: bad entry in directory #423505: unaligned directory entry
> - offset=0, inode=6517874, rec_len=12655, name_len=48

This error caused by below error...

> Oct  6 17:11:08 fargo kernel: hda: status error: status=0x58 { DriveReady
> SeekComplete DataRequest }

I've only seen this myself when I've been messing with hdparm on a ide drive

> Oct  6 17:11:08 fargo kernel: hda: drive not ready for command
> Oct  6 17:11:08 fargo kernel: hdb: ATAPI DVD-ROM drive, 512kB Cache
> Oct  6 17:11:08 fargo kernel: Uniform CD-ROM driver Revision: 3.12
> Oct  6 17:11:09 fargo kernel: VFS: Disk change detected on device
> ide0(3,64)
> 
> 
> Any hints are welcome, thanks.
> 

Yeah.  If you can't figure out hdparm, leave it alone.

> 
> David G?mez
> 

Mike

