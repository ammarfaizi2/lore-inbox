Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSINX4g>; Sat, 14 Sep 2002 19:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSINX4g>; Sat, 14 Sep 2002 19:56:36 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:33503 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317624AbSINX4f>; Sat, 14 Sep 2002 19:56:35 -0400
Date: Sat, 14 Sep 2002 21:01:07 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Marc-Christian Petersen <m.c.p@gmx.de>
cc: linux-kernel@vger.kernel.org, <procps-list@redhat.com>
Subject: Re: [PATCH] procps-208-20020915 against Rik van Riel's procps-207-20020913
In-Reply-To: <200209150130.21224.m.c.p@gmx.de>
Message-ID: <Pine.LNX.4.44L.0209142059290.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0209142059292.1857@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Marc-Christian Petersen wrote:

> o  minimal cosmetic fixes. Looks a bit nicer now (imo) :)
> o  Added OC (overcommit_memory) to be shown from /proc/sys/kernel in top
>     maybe you find this usefull or totally useless ;) ... I like it.

Having the top header take up yet another line is probably
not a good idea, but I guess we could get rid of the 'shared'
stat by 2.6 time and inactive_clean/target can also be gotten
rid of.

On the other hand, this might start breaking all kinds of
scripts left and right, so we need to be careful with that...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

