Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284540AbRLES14>; Wed, 5 Dec 2001 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284554AbRLES1q>; Wed, 5 Dec 2001 13:27:46 -0500
Received: from mustard.heime.net ([194.234.65.222]:60053 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284547AbRLES1h>; Wed, 5 Dec 2001 13:27:37 -0500
Date: Wed, 5 Dec 2001 19:27:07 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.33L.0112051622050.4079-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.30.0112051924560.3073-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect the per-device readahead for IDE is limiting the
> effect of vm_max_readahead ...

hm...

any way to avoid this? I mean... The readahead in vm is layered above the
actual device, and should therefore not be limited... Am I right? You
could do several device calls, and fake readahead, and probably get pretty
much out of it.


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

