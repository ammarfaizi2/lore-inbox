Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbSJCWYz>; Thu, 3 Oct 2002 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261342AbSJCWYz>; Thu, 3 Oct 2002 18:24:55 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:924 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261186AbSJCWYy>; Thu, 3 Oct 2002 18:24:54 -0400
Date: Thu, 3 Oct 2002 19:30:13 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] improve wchan reporting
In-Reply-To: <20021003182144.G16875@redhat.com>
Message-ID: <Pine.LNX.4.44L.0210031928590.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Oct 2002, Benjamin LaHaise wrote:

> frame pointer.  Another option is to make wchan an actual file in the task,
> which has the added bonus of being somewhat more useful with aio.  In any
> case, I'd like to hear what other people think about the problem, as having
> 95% of tasks show up in __down or schedule_timeout makes tracking down some
> problems a lot harder.  The patch is against bk-cur.

A third option could be a /proc/$pid/backtrace file which
contains the whole backtrace for a process and teach procps
to ignore certain functions.

I prefer your solution, though ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

