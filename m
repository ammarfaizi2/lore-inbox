Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267313AbTA0WMF>; Mon, 27 Jan 2003 17:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263899AbTA0WMF>; Mon, 27 Jan 2003 17:12:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21769 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267313AbTA0WME>; Mon, 27 Jan 2003 17:12:04 -0500
Date: Mon, 27 Jan 2003 17:18:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.21-pre3-jam3
In-Reply-To: <20030126003309.GG1507@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1030127171313.27928J-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, J.A. Magallon wrote:

> Changelog:
> - aa updated to -pre3-aa1
> - highpage_init integrated in -aa
> - killed cd-read-audio-dma, because it was giving too much oopses...

Is someone working on this (assuming it will eventually get into 2.6)? It
seems to make a worthwhile improvement when ripping CDs. Not as worthwhile
as stability, obviously ;-)

> - 37-ext3-scheduling-storm.bz2
>     Fixes an inefficiency and potential system lockup in ext3 filesystem.
>     Anyone who is using tasks which have realtime scheduling policy on ext3
>     systems should apply this change.
>     Author: Andrew Morton <akpm@digeo.com>

Hum, I believe that means cdrecord, although I've never seen a problem.

> Enjoy !!

Thanks for the integration.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

