Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133110AbREFH5y>; Sun, 6 May 2001 03:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133113AbREFH5p>; Sun, 6 May 2001 03:57:45 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:42197 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S133110AbREFH5h>;
	Sun, 6 May 2001 03:57:37 -0400
From: thunder7@xs4all.nl
Date: Sun, 6 May 2001 07:47:15 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Linux 2.4.4-ac5; hpt370 & new dma setup
Message-ID: <20010506074715.A7138@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <01050514375300.14219@oscar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <01050514375300.14219@oscar>; from tomlins@cam.org on Sat, May 05, 2001 at 02:37:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 02:37:53PM -0400, Ed Tomlinson wrote:
> thunder7@xs4all.nl wrote:
> 
> >> 2.4.4-ac5
> >> o	Fix DMA setup on hpt366/370			(Tim Hockin)
> > 
> > I see definite changes; on heavy disk-access I got the following:
> > 
> > hdg: timeout waiting for dma
> > ide_dmaproc: chipset supported ide_dma_timeout func only:14
> > hdg: irq timeout: status = 0x58 { DriveReady SeekComplete DataRequest}
> > 
> > this was repeated several times, and ide3 was being reset, but the
> > kernel hung anyway after 5 minutes of waiting.
> > 
> > I must have an unlucky set of hardware (via chipset VP6 board, Live!,
> > ibm drives).
> 
> Funny I have had the same problem with 2.4.4 only with a pdc20267 (reported
> to lkml with topic '[BUG] pdc20267 and dma timeouts')  Is there some problem 
> with resets on ide2/3?
> 
I never saw it before, and this isn't the first time I've expired my
news-spool, did a make -j5 and a man -k at the same time.

Jurriaan
-- 
Backup Not Found (A)ssasinate Bill Gates (R)etry (K)eep trying until 6 am?
GNU/Linux 2.4.4 SMP/ReiserFS 2x1743 bogomips load av: 0.00 0.00 0.00
