Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbRL2NCL>; Sat, 29 Dec 2001 08:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287191AbRL2NB6>; Sat, 29 Dec 2001 08:01:58 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:54535 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287189AbRL2NBr>;
	Sat, 29 Dec 2001 08:01:47 -0500
Date: Sat, 29 Dec 2001 11:01:29 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <esr@thyrsus.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system
In-Reply-To: <Pine.LNX.4.33.0112281504210.23482-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0112291058060.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Linus Torvalds wrote:

> Having per-function comment blocks, in contrast, makes sense to have
> inline:
>
>  - you read the comment when you read the function
>  - you might even update the comment when you update the function
>  - you have a reasonable 1:1 relationship.

Personally I'd like to see each C file have a header like
this too, describing in a few lines what the functions in
this file are supposed to do.

This should make it easier for people to figure out not just
what each C file is about, but also if they should spend their
time wading through this particular C file when in search of
some piece of code.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

