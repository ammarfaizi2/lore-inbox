Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319703AbSIMQSX>; Fri, 13 Sep 2002 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319704AbSIMQSX>; Fri, 13 Sep 2002 12:18:23 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:25040 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319703AbSIMQSW>; Fri, 13 Sep 2002 12:18:22 -0400
Date: Fri, 13 Sep 2002 13:22:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Con Kolivas <conman@kolivas.net>
cc: linux-kernel@vger.kernel.org, <gh@us.ibm.com>
Subject: Re: System response benchmarks in performance patches
In-Reply-To: <1031933335.3d820d97a13c6@kolivas.net>
Message-ID: <Pine.LNX.4.44L.0209131320130.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Con Kolivas wrote:

> I came up with a very simple way of measuring responsiveness that gives
> me numbers that are meaningful to me. What I've done is the old faithful
> kernel compile and measured it under different loads to simulate the
> pc's ability to perform under various loads.

Absolutely wonderful.  I'd love to see this easily scriptable
so we can just run it with one command, eg:

$ ./contest

> Kernel			Time		%CPU
> 2.4.19			3:00.76		58%
> 2.4.19-ck7			2:01.68		86%
> 2.4.19-ck7-rmap		2:05.95		83%
> 2.4.18-6mdk    	        3:01.48         58%

Very interesting results. People benchmarking just one thing
at a time won't get variances anywhere near this big, while
real system workload is pretty much always multitasking.

I think I've finally found a benchmark that gives results which
are meaningful in the context of a multitasking system.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

