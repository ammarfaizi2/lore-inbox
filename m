Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285591AbRLGWCe>; Fri, 7 Dec 2001 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285590AbRLGWCZ>; Fri, 7 Dec 2001 17:02:25 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:27660 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S285584AbRLGWCO>;
	Fri, 7 Dec 2001 17:02:14 -0500
Date: Fri, 7 Dec 2001 20:02:01 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Pablo Borges <pablo.borges@uol.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <Pine.LNX.4.33.0112072209520.989-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33L.0112072001180.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001, Mike Galbraith wrote:
> On Fri, 7 Dec 2001, Alan Cox wrote:
>
> > > In Rik's VM I had a problem with use-once when Bonnie was doing
> > > rewrite.  It's used-twice data became too hard to get rid of at
> >
> > You are not supposed to use Riel's VM with use-once. The two were never
> > intended to be combined.
>
> I like the idea behind use-once very much, but given the side-effects
> seen here.... I'm not sure.

Page aging achieves something pretty close to use-once, but
without the side effects. Pages which are used once put some
pressure on the working set, but very little.

kind regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

