Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317947AbSG1EnA>; Sun, 28 Jul 2002 00:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318901AbSG1EnA>; Sun, 28 Jul 2002 00:43:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20742 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317947AbSG1Em7>; Sun, 28 Jul 2002 00:42:59 -0400
Date: Sat, 27 Jul 2002 21:47:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] automatic initcalls
In-Reply-To: <3D436A44.8080505@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0207272145050.6125-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Jul 2002, Jeff Garzik wrote:
>
> I've always preferred a system where one simply lists dependencies [as
> you describe above], and some program actually does the hard work of
> chasing down all the initcall dependency checking and ordering.
>
> Linus has traditionally poo-pooed this so I haven't put any work towards
> it...

I don't hate the notion, but at the same time every time it comes up I
feel that there are reasonably simple ways to just avoid the ordering
problems.

Rusty had a script, but somebody complained about the speed of it. I
haven't looked at it myself.

		Linus

