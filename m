Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSGASKy>; Mon, 1 Jul 2002 14:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSGASKx>; Mon, 1 Jul 2002 14:10:53 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56591 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315941AbSGASKw>; Mon, 1 Jul 2002 14:10:52 -0400
Date: Mon, 1 Jul 2002 14:08:32 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [OKS] Async IO
Message-ID: <Pine.LNX.3.96.1020701140036.23896A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds like the right way to go. I always thought blocking i/o was for the
benefit of the o/s, but with read-ahead and buffered writes the gain will
be essentially invisible for many things. I admit that the first
development team I ever joined used async io for everything, writing a new
o/s for GE, then in the mainframe business, so I may not be neutral;-)

This has been less of an issue with low cost process creation, several
processes using IPC and blocking io are probably no harder to get right
than a bunch of async io, but this is a good time to add the capability.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

