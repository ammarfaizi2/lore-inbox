Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319296AbSIFRhr>; Fri, 6 Sep 2002 13:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319301AbSIFRhr>; Fri, 6 Sep 2002 13:37:47 -0400
Received: from iris.mc.com ([192.233.16.119]:31388 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S319296AbSIFRhp>;
	Fri, 6 Sep 2002 13:37:45 -0400
Message-Id: <200209061742.NAA20207@mc.com>
Content-Type: text/plain; charset=US-ASCII
From: mbs <mbs@mc.com>
To: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
Date: Fri, 6 Sep 2002 13:46:47 -0400
X-Mailer: KMail [version 1.3.1]
References: <200209061713.51387.devilkin-lkml@blindguardian.org>
In-Reply-To: <200209061713.51387.devilkin-lkml@blindguardian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fdisk/format and reinstall but stick with a 2.4.19 or 2.4.19-ac kernel.

I would bet money that the problem is purely a .20-preX-acX thing.

run it a while on 2.4.19 to verify that life is good.  then build a new 
2.4.20-pre1-ac3 and boot it. I bet that within minutes of normal use, you 
will have a problem.

(I have done this loop 3 times.)

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
