Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSABGLx>; Wed, 2 Jan 2002 01:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286766AbSABGLo>; Wed, 2 Jan 2002 01:11:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:17928 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286758AbSABGLe>;
	Wed, 2 Jan 2002 01:11:34 -0500
Date: Wed, 2 Jan 2002 04:11:20 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] 2.4.17 rmap based VM #10
In-Reply-To: <Pine.LNX.4.33L.0201020239070.24031-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33L.0201020410290.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Rik van Riel wrote:

> The 10th version of the reverse mapping based VM is now available.
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time. The patch
> is available from:
>
>            http://surriel.com/patches/2.4/2.4.17-rmap-10
> and        http://linuxvm.bkbits.net/

Of course, Andrew Morton found a logic inversion bug in
wakeup_kswapd() which could cause system hangs. Please
get this patch instead:

	http://surriel.com/patches/2.4/2.4.17-rmap-10a

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

