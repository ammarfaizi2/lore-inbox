Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVBAQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVBAQgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVBAQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:36:04 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:13972 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262060AbVBAQf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:35:58 -0500
Date: Tue, 1 Feb 2005 17:36:44 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>,
       Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Michael Buesch <mbuesch@freenet.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: My System doesn't use swap!
Message-ID: <20050201163644.GC685@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Matthias-Christian Ott <matthias.christian@tiscali.de>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <D25F0ABA-73C6-11D9-B5F9-000393ACC76E@mac.com> <41FFA52C.606@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41FFA52C.606@tmr.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bill :)

 * Bill Davidsen <davidsen@tmr.com> dixit:
> >Swap is orders of magnitude slower than RAM. Why put things there if you
> >still have RAM left?  The kernel only puts things in swap when it has no
> >more RAM _and_ has already deleted big chunks of its disk cache.
> Unless he just booted, I would expect at least a little use of the swap, 
> something like this, on a machine with 1GB RAM and not much happening. 

    I have 2.4.29 running and uptime is about 24 hours now, and with
1Gig of RAM and a loadavg in the last 15 minutes has been 4, more or
less, and I have 130 megs of free memory and none of my 512 megs swap
is used. And this is very common for me. The only way of using swap
is starting X, mozilla (some pre-firefox version will do) and one of
the many memory leaking apps available for the X Window System. On
console, with the apps I run usually (that includes setiathome too,
and heavy use of the C compiler) I don't hit swap. This is my memory
status right now:

         total:     used:     free:  shared: buffers:   cached:
Mem:  927006720 796491776 130514944        0  5517312 738082816
Swap: 536862720         0 536862720
MemTotal:       905280 kB
MemFree:        127456 kB
MemShared:           0 kB
Buffers:          5388 kB
Cached:         720784 kB
SwapCached:          0 kB
Active:           7096 kB
Inactive:       719092 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       905280 kB
LowFree:        127456 kB
SwapTotal:      524280 kB
SwapFree:       524280 kB

    Pretty low usage, and still more than 700MB of cached memory
available to avoid using swap.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
