Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSGXUCE>; Wed, 24 Jul 2002 16:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSGXUAj>; Wed, 24 Jul 2002 16:00:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:10763 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317517AbSGXUAe>; Wed, 24 Jul 2002 16:00:34 -0400
Date: Wed, 24 Jul 2002 15:58:12 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Safety of IRQ during i/o
Message-ID: <Pine.LNX.3.96.1020724154712.7034C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The man page for hdparm is a bit dated on the -u flag allowing ints during
i/o, warning about the dangers of using kernels older than 2.0.13. No
problem there, but what are the more current implications?

I would think that this would be safe when using DMA, and likely to be
safe for PIO and more recent chipsets, but I wouldn't want to actually
tell anyone that.

Therefore:
 1 - the man page would benefit from an update regarding recent kernels
     from this millenium, if only to reassure readers.
 2 - any better way to tell if allowing ints will cause problems than just
     to try it? Not desirable on large machines, but it was off and I am
     seeing serial problems on the OOB access modem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

