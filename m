Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272605AbRHaFFA>; Fri, 31 Aug 2001 01:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272606AbRHaFEu>; Fri, 31 Aug 2001 01:04:50 -0400
Received: from 24.159.204.122.roc.nc.chartermi.net ([24.159.204.122]:50948
	"EHLO tweedle.cabbey.net") by vger.kernel.org with ESMTP
	id <S272605AbRHaFEp>; Fri, 31 Aug 2001 01:04:45 -0400
Date: Fri, 31 Aug 2001 00:05:01 -0500 (CDT)
From: Chris Abbey <linux@cabbey.net>
X-X-Sender: <cabbey@tweedle.cabbey.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <Pine.LNX.4.30.0108302117150.16904-100000@anime.net>
Message-ID: <Pine.LNX.4.33.0108302353380.4964-100000@tweedle.cabbey.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today, Dan Hollis wrote:
> but where would the finger start pointing then?

hmm... *compiler optimizations* for a specific family cause
problems on that family, but *compiler optimizations* for
a lesser family don't... I'll admit my kernel h4x0|^ 5k1!!s
aren't on par with most on this list, but has anyone thought
to take a look at the *compiler optimizations* that are
generated? It sure wouldn't be a first if the combination
of agressive optimizations and complex kernel code exposed
a subtle and/or complex bug in one, the other, or both...
and different levels of compiler might explain why some
have the problems, and others don't.

Having spent way too many hours this week looking at highly
optimized 64bit ppc assembly I can only say that <drawl
type=hick> them thar compiler hackors is devious lil
twerps when yas ask fer all the bells n wistles. </drawl>

This of course is all assuming that one or more folks do
recreate it on obviously good hardware. ;)

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

