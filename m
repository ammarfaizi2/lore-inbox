Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282866AbRLMNK0>; Thu, 13 Dec 2001 08:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283876AbRLMNKQ>; Thu, 13 Dec 2001 08:10:16 -0500
Received: from ns.suse.de ([213.95.15.193]:36875 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282866AbRLMNKE>;
	Thu, 13 Dec 2001 08:10:04 -0500
Date: Thu, 13 Dec 2001 14:10:01 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Over-enthusiastic OOM killer.
In-Reply-To: <200112130734.fBD7YXU01306@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112131407250.28164-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Linus Torvalds wrote:

> >The oom killer just killed a bunch of processes on my workstation.
> >What I don't understand, is why this was deemed necessary, when
> >there was 400MB of buffer cache sitting around in memory, and 175MB
> >of free swap space unused. (66mb of swap was used)
>
> Ehh.. I bet you didn't have free swap.

Difficult to say after the killing, but even if that were the case,
why wasn't buffer cache pruned before the more drastic action ?

After the killing, there was 400MB of real memory, doing absolutely
nothing but holding cached data.

regards,
Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

