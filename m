Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281150AbRKENlh>; Mon, 5 Nov 2001 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281151AbRKENla>; Mon, 5 Nov 2001 08:41:30 -0500
Received: from pasky.ji.cz ([62.44.12.54]:19438 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S281150AbRKENlP>;
	Mon, 5 Nov 2001 08:41:15 -0500
Date: Mon, 5 Nov 2001 14:41:12 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: Jakob ?stergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011105144112.Q11619@pasky.ji.cz>
Mail-Followup-To: Jakob ?stergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <160MMf-1ptGtMC@fmrl05.sul.t-online.com> <20011104143631.B1162@pelks01.extern.uni-tuebingen.de> <160Nyq-2ACgt6C@fmrl07.sul.t-online.com> <20011104163354.C14001@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011104163354.C14001@unthought.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> We want to avoid these problems:
>  1)  It is hard to parse (some) /proc files from userspace
>  2)  As /proc files change, parsers must be changed in userspace
> 
> Still, we want to keep on offering
>  3)  Human readable /proc files with some amount of pretty-printing
>  4)  A /proc fs that can be changed as the kernel needs those changes

  I've read the whole thread, but i still don't get it. Your solution doesn't
improve (1) for parsers in scripting languages, where it is frequently far
easier to parse ASCII stuff than messing with binary things, when not almost
impossible. So we don't make any progress here.  And for languages like C,
where this will have most use, there actually is solution and it is working.
So, please, can you enlighten me, what's so wrong on sysctl? It actually
provides exactly what do you want, and you even don't need to bother yourself
with open() etc ;). So it would be maybe better improving sysctl interface,
especially mirroring of all /proc stuff there, instead of arguing about scanf()
:-).

  So can you please explain me merits of your approach against sysctl?

-- 

				Petr "Pasky" Baudis

UN*X programmer, UN*X administrator, hobbies = IPv6, IRC
Real Users hate Real Programmers.
Public PGP key, geekcode and stuff: http://pasky.ji.cz/~pasky/
