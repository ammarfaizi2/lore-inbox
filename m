Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJJUcI>; Wed, 10 Oct 2001 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbRJJUb6>; Wed, 10 Oct 2001 16:31:58 -0400
Received: from [216.151.155.121] ([216.151.155.121]:10513 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S274667AbRJJUbs>; Wed, 10 Oct 2001 16:31:48 -0400
To: Stephen Torri <storri@ameritech.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory free report error (kernel-2.4.10-ac10)
In-Reply-To: <Pine.LNX.4.33.0110101605120.733-100000@base.torri.linux>
From: Doug McNaught <doug@wireboard.com>
Date: 10 Oct 2001 16:32:18 -0400
In-Reply-To: Stephen Torri's message of "Wed, 10 Oct 2001 16:10:58 -0400 (EDT)"
Message-ID: <m34rp75j8t.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Torri <storri@ameritech.net> writes:

> I have installed and used kernel-2.4.10-ac10 on a SMP system (Dual P3)
> using 768 MB Ram. Yet on startup of the system (RedHat 7.0), the system
> resources are almost all used. Here are the files started:
> 
> Here is the report of the memory (free -m):
>              total       used       free     shared    buffers     cached
> Mem:           751        662         89          0        564         18
> -/+ buffers/cache:         78        672
> Swap:          133          0        133

Unless I'm missing something, this is completely normal.  You're using 
78M of memory once buffers are factored out.  Seems reasonable for a
just-started system.

For comparison, here's a moderately loaded machine running 2.2.19:

[doug@scooby doug]$ free -m
             total       used       free     shared    buffers     cached
Mem:           505        480         24        137         42        278
-/+ buffers/cache:        159        345
Swap:          101          0        101

Are you actually seeing performance problems or are you just worried
about the 'free' output?

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
