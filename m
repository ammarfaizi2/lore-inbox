Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTBOLM5>; Sat, 15 Feb 2003 06:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTBOLM5>; Sat, 15 Feb 2003 06:12:57 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:50403 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261868AbTBOLMk>; Sat, 15 Feb 2003 06:12:40 -0500
Date: Sat, 15 Feb 2003 09:22:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Mike Galbraith <efault@gmx.de>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CFQ scheduler, #2
In-Reply-To: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
Message-ID: <Pine.LNX.4.50L.0302150920510.16301-100000@imladris.surriel.com>
References: <5.1.1.6.2.20030215105330.00c84da8@pop.gmx.net>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.50L.0302150920512.16301@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Mike Galbraith wrote:

> I gave this a burn, and under hefty load it seems to provide a bit of
> anti-thrash benefit.

Judging from your log, it ends up stalling kswapd and
dramatically increases the number of times that normal
processes need to go into the pageout code.

If this provides an anti-thrashing benefit, something's
wrong with the VM in 2.5 ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
