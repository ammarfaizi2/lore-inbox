Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289347AbSA1Tky>; Mon, 28 Jan 2002 14:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSA1Tkt>; Mon, 28 Jan 2002 14:40:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:26127 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289344AbSA1Tkm>;
	Mon, 28 Jan 2002 14:40:42 -0500
Date: Mon, 28 Jan 2002 17:40:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Vincent Sweeney <v.sweeney@barrysworld.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: <002801c1a832$d38933e0$0201010a@frodo>
Message-ID: <Pine.LNX.4.33L.0201281739190.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Vincent Sweeney wrote:

> > >     CPU0 states: 27.2% user, 62.4% system,  0.0% nice,  9.2% idle
> > >     CPU1 states: 28.4% user, 62.3% system,  0.0% nice,  8.1% idle
> >
> > The important bit here is     ^^^^^^^^ that one. Something is causing
> > horrendous lock contention it appears.
>
> I've switched a server over to the default eepro100 driver as supplied
> in 2.4.17 (compiled as a module). This is tonights snapshot with about
> 10% higher user count than above (2200 connections per ircd)

Hummm ... poll() / select() ?  ;)

> I will try the profiling tomorrow

readprofile | sort -n | tail -20

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

