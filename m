Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130806AbRCFAzJ>; Mon, 5 Mar 2001 19:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130811AbRCFAzA>; Mon, 5 Mar 2001 19:55:00 -0500
Received: from julia.fractalus.com ([208.33.249.70]:35851 "HELO
	julia.fractalus.com") by vger.kernel.org with SMTP
	id <S130806AbRCFAys>; Mon, 5 Mar 2001 19:54:48 -0500
Date: Mon, 5 Mar 2001 19:48:20 -0500 (EST)
From: SteveC <steve@fractalus.com>
To: Amit Chaudhary <amitc@brocade.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: continous hard disk trashing and error messages - 2.4.2-ac5
In-Reply-To: <FFD40DB4943CD411876500508BAD027901DE2C12@sj5-ex2.brocade.com>
Message-ID: <Pine.LNX.4.10.10103051943500.28033-100000@julia.fractalus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Amit Chaudhary wrote:
> For the kernel 2.4.2 with the patch 2.4.2-ac5 patch, I have been getting continous hard disk trashing and the following errors in the /var/log/messages. I increased the console log level to avoid the messages. Please see below a sample set
> Mar  5 12:15:59 amitc-linux mount: mount: can't open /etc/mtab for writing: Input/output error
> Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> Mar  5 12:16:04 amitc-linux kernel: hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=25133118, sector=3670215
> Mar  5 12:16:04 amitc-linux kernel: end_request: I/O error, dev 03:06 (hda), sector 3670215
> Mar  5 12:16:04 amitc-linux kernel: EXT2-fs error (device ide0(3,6)): ext2_write_inode: unable to read inode block - inode=230017, block=458776

hmmm. I had the same things from vanilla 2.4.2 on my laptop but luckily it
wiped out non essential stuff. I migrated back to 2.2.18.

I assumed it must be something stupid that I am doing but I have yet to
find it.

details - ext2fs main partition went awol. Had to manual fsck with much of
the above happening and lost+found filled up with stuff. anything else on
request. Still hoping its something stupid my end but doesn't appear to be
DMA stuf... I don't know.

have fun,

pub  1024D/A9D75E73 2000-05-30 Stephen Coast (SteveC) <steve@fractalus.com>
[expires:2001-05-30] www.fractalus.com/steve/ <stevecoast@hushmail.com>

