Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263050AbSJFAaf>; Sat, 5 Oct 2002 20:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbSJFAaf>; Sat, 5 Oct 2002 20:30:35 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:48084 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263050AbSJFAae>; Sat, 5 Oct 2002 20:30:34 -0400
Date: Sat, 5 Oct 2002 21:36:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Gigi Duru <giduru@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
In-Reply-To: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44L.0210052134561.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Gigi Duru wrote:

> Trivial experiment: configure out _ALL_ the options on
> 2.5.38 and build bzImage. My result? A totally useless
> 270KB kernel (compressed).
>
> Now try to put in some useful stuff and the
> _compressed_ image will cheerfully approach 1MB.

> I know you guys are struggling to bring "world class
> VM & IO" to Linux,

The 270 kB kernel image still includes the VM, so it's
probably something else that is bloating your kernel.

It would be useful to figure out exactly what so we can
fix it before 2.6 is released.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

