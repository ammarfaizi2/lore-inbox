Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLFAZE>; Tue, 5 Dec 2000 19:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQLFAYy>; Tue, 5 Dec 2000 19:24:54 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:45581 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129524AbQLFAYr>; Tue, 5 Dec 2000 19:24:47 -0500
Date: Wed, 6 Dec 2000 00:54:18 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_nat_ftp and different ports (Solved)
In-Reply-To: <Pine.LNX.4.21.0012051526460.12507-100000@hewpac.taco.dhs.org>
Message-ID: <Pine.LNX.4.21.0012060052470.18423-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, after having no time for a coule of days, back to business ;))
> I've downloaded + applied the ftp-multi patch and recompiled the modules.
> then loaded them with ports=21,41,42,62,63, which works (well, no
> errors/warnings...).
> Then trying the application for which i needed it: doesn't work ;((
> 
> Are there maybe some major/crucial differences between the 2.2.x version
> (which works) of ip_masq_ftp and the 2.4.x version of ip_nat_ftp ??
OK, stupid me forgot to use 'modprobe ip_conntrack_ftp ports=41,42,62,63'
in addition to ip_nat_ftp module ...

Everything works perfectly now, and I can keep running 2.4 ;))

Cheers,
Taco.
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
