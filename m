Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTEMUD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTEMUD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:03:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47881 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261916AbTEMUDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:03:25 -0400
Date: Tue, 13 May 2003 16:08:54 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Felix von Leitner <felix-kernel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69: VIA IDE still broken
In-Reply-To: <20030508220910.GA1070@codeblau.de>
Message-ID: <Pine.LNX.3.96.1030513160559.18019B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Felix von Leitner wrote:

> I can't believe this still isn't fixed!
> 
>  hda: dma_timer_expiry: dma status == 0x24
>  hda: lost interrupt
>  hda: dma_intr: bad DMA status (dma_stat=30)
>  hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
>  hda: dma_timer_expiry: dma status == 0x24
>  hda: lost interrupt
>  hda: dma_intr: bad DMA status (dma_stat=30)
>  hda: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> My hda is in perfect health and this does not happen on the same
> hardware with 2.4.* or 2.5.63.

That seems to reduce the chances of hardware problems. At the least later
kernels tickle the problem if there is one.

> hardware with 2.4.* or 2.5.63.  I reported this before and got the
> answer that to fix this, recent changes in the IDE code would have to be
> reverted.  Apparently I was unreasonably hasty in assuming that that
> would be done now that the need to do it has been established.
> 
> I would appreciate it if the fix would be integrated into 2.5.70.

I wouldn't assume that the fix is known and as simple as you seem to
think. Other people aren't having the problem. Doesn't mean there isn't
one, but the changes you want reverted were made for a reason.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

