Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136542AbRECJy2>; Thu, 3 May 2001 05:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136560AbRECJyW>; Thu, 3 May 2001 05:54:22 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:3969 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S136542AbRECJyD>; Thu, 3 May 2001 05:54:03 -0400
Date: Thu, 3 May 2001 11:53:58 +0200
From: Cliff Albert <cliff@oisec.net>
To: poptix <poptix@poptix.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.4, 2.4.4-ac1, 2.4.4-ac2, neighbour discovery bug (ipv6)
Message-ID: <20010503115358.A7793@oisec.net>
In-Reply-To: <20010501154437.A23200@oisec.net> <Pine.LNX.4.33.0105022155090.444-100000@3jane.ashpool.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33.0105022155090.444-100000@3jane.ashpool.org>; from poptix@poptix.net on Wed, May 02, 2001 at 09:56:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2001 at 09:56:20PM +0200, poptix wrote:

> >
> > When i traceroute6 my 2.4.4 box on my local lan, the 2.4.4 box panic's after about 10 seconds. The traceroute6 completes on the other box.
> >
> > 2.4.3-ac14 doesn't experience these problems. Only 2.4.4 (with or without ac{1,2}) panics
> >
> > ---- traceroute6 output ----
> > traceroute to neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a) from 3ffe:8114:2000:0:210:4bff:feb3:1fb4, 30 hops max, 16 byte packets
> >  1  neve.oisec.net (3ffe:8114:2000:0:250:bfff:fe21:629a)  0.583 ms  0.278 ms  0.233 ms
> >
> >
> [snip]
> 
> I am unable to reproduce this, either locally or remotely, I am also using
> the 2.4.4 kernel, do you have any more information on this, and is it
> possible to reproduce every time?

Was reproducable every single time, on multiple machines. a simple PING6 or TRACEROUTE6 would kill the box. Using native connection or tunneled connection doesn't matter after some investigation.

-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE
