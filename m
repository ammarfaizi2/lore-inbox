Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284553AbRLESX0>; Wed, 5 Dec 2001 13:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284546AbRLESXQ>; Wed, 5 Dec 2001 13:23:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53261 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284543AbRLESXD>;
	Wed, 5 Dec 2001 13:23:03 -0500
Date: Wed, 5 Dec 2001 16:22:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.21.0112051450310.20481-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0112051622050.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Marcelo Tosatti wrote:
> On Wed, 5 Dec 2001, Roy Sigurd Karlsbakk wrote:
>
> > I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
> > available. I've got this idea...
> >
> > If lots of files (some hundered) are read simultaously, I waste all the
> > i/o time in seeks. However, if I increase the readahead, it'll read more
> > data at a time, and end up with seeking a lot less.
>
> Do you also have VM pressure going on or do you have lots of free memory ?

I suspect the per-device readahead for IDE is limiting the
effect of vm_max_readahead ...

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

