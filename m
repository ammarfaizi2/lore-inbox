Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318717AbSIFP3W>; Fri, 6 Sep 2002 11:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318736AbSIFP3W>; Fri, 6 Sep 2002 11:29:22 -0400
Received: from iris.mc.com ([192.233.16.119]:56033 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S318717AbSIFP3B>;
	Fri, 6 Sep 2002 11:29:01 -0400
Message-Id: <200209061533.LAA11203@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
Date: Fri, 6 Sep 2002 11:37:59 -0400
X-Mailer: KMail [version 1.3.1]
References: <200209061713.51387.devilkin-lkml@blindguardian.org>
In-Reply-To: <200209061713.51387.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same problem I was having with 2.4.20-pre4-ac2-preempt.

alan didn't want to hear it from me due to the -preempt

my system was e7500 chipset, dual xeon, WD 40g drive, ext2 or ext3.

from this we can glean: preempt not a factor, HD manufacturer not a factor, 
FS not a factor.  don't know what chipset you are using.

I was allso geting badCRC errors.

On Friday 06 September 2002 11:13, DevilKin wrote:
> Hello kernel people,
>
> Kernel running: 2.4.20-pre1ac3 or -pre5ac2 (same under both)
>
> Today I discovered a stale copy of qt-3.0.3 lying about on my disk. When I
> tried to delete it, this started showing up in my log files:
>
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862,
> sector=1803472
> end_request: I/O error, dev 03:06 (hda), sector 1803472
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
> data of [612671 612672 0x0 SD]
> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=7072862,
> sector=1803472
> end_request: I/O error, dev 03:06 (hda), sector 1803472
> vs-13070: reiserfs_read_inode2: i/o failure occurred trying to find stat
> data of [612671 612677 0x0 SD]
>
> and rm just reported me 'Permission denied'.
>
> I've looked up these errors on the net, and as far as i can tell it means
> that the drive has some bad sectors at the given addresses and that it will
> probably die on me sooner or later.
>
> Can someone either confirm this to me or tell me what to do to fix it?
>
> The drive involved is an IBM-DTLA-307060, which has served me without
> problems now for about 2 years.
>
> Thanks!
>
> DK

-- 
/**************************************************
**   Mark Salisbury       ||      mbs@mc.com     **
** If you would like to sponsor me for the       **
** Mass Getaway, a 150 mile bicycle ride to for  **
** MS, contact me to donate by cash or check or  **
** click the link below to donate by credit card **
**************************************************/
https://www.nationalmssociety.org/pledge/pledge.asp?participantid=86736
