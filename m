Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313469AbSC2PvP>; Fri, 29 Mar 2002 10:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313465AbSC2PvG>; Fri, 29 Mar 2002 10:51:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27920 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313467AbSC2Pup>; Fri, 29 Mar 2002 10:50:45 -0500
Date: Fri, 29 Mar 2002 10:47:55 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: pjd@fred001.dynip.com
cc: robert@schwebel.de, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Networking with slow CPUs
In-Reply-To: <200203291133.g2TBXsi10506@fred.cambridge.ma.us>
Message-ID: <Pine.LNX.3.96.1020329104533.22866C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 pjd@fred001.dynip.com wrote:

> Robert Schwebel wrote:
> > 
> > Is there a possibility to "harden" a small machine (33 MHz embedded
> > device) against e.g. flood pings from the outside world?
> 
> It *is* bleeding edge, as someone else pointed out, but you should 
> really investigate NAPI.  It's designed to make Linux resiliant against
> non-flow-controlled network loads like routing, which sounds like 
> just the ticket.

  There is rate limiting in recent iptables, as well. I don't regard
iptable as bleeding edge, so that may have a higher comfort level.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

