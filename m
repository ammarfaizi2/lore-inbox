Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286676AbRLVEx2>; Fri, 21 Dec 2001 23:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286675AbRLVExQ>; Fri, 21 Dec 2001 23:53:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:20998 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286672AbRLVEwz>;
	Fri, 21 Dec 2001 23:52:55 -0500
Date: Sat, 22 Dec 2001 02:44:18 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Sasha Pachev <sasha@mysql.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: disabling kswapd
In-Reply-To: <200112220117.fBM1HLM00755@mysql.sashanet.com>
Message-ID: <Pine.LNX.4.33L.0112220212010.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Sasha Pachev wrote:

> http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.0/0675.html. I
> adapted it to my kernel ( 2.4.17-rc2), disabled kswapd, did some
> testing and noticed much better performance.

This is very hard to believe.

If kswapd does not run, it just means that _other_ processes
will run the exact same code, only synchronously (instead of
having kswapd do the cleanup for them).

kind regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

