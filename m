Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317185AbSFBOBM>; Sun, 2 Jun 2002 10:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSFBOBL>; Sun, 2 Jun 2002 10:01:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1294 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317185AbSFBOBJ>;
	Sun, 2 Jun 2002 10:01:09 -0400
Date: Sun, 2 Jun 2002 16:03:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Ion Badulescu <ionut@cs.columbia.edu>, linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020602160357.A1726@mars.ravnborg.org>
In-Reply-To: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu> <Pine.LNX.4.44.0206020139510.29405-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2002 at 01:58:10AM -0600, Thunder from the hill wrote:
[cc: list trimmed]

> I split it so that you can merge some stuff in and it has no effect. You 
> can even merge the whole thing in with no effect as long as you're using 
> the old Makefile,v 2.4.

Piecemal is not about splitting the patch in small bits only.
It's about adding features one-by-one, and about fixing bugs one-by-one.
Forget the story that current kbuild-2.5 needs the core in order to
enable any functionality.
A small list of stuff independent of the core stuff:
o New defconfig target
o New installable target
o Replacement of installkernel script with a couple of commandline options
o asmoffset stuff, allthough not used for i386 at present
o The idea behind _shipped prefix on shipped files
o randconfig, warnings in split-include, mkdep, 2048 symbol limit, dbl qoutes
o Quit output, making warnings more visible
o etc.

I think Linus did not want to take a patch that changed too much, and
thats what kbuild-2.5 does. This does not change when you split it up
file by file.

	Sam
