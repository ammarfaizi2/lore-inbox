Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287342AbSAGXOF>; Mon, 7 Jan 2002 18:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287351AbSAGXOA>; Mon, 7 Jan 2002 18:14:00 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33555 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287342AbSAGXNd>;
	Mon, 7 Jan 2002 18:13:33 -0500
Date: Mon, 7 Jan 2002 21:13:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving oom detection in rmap10c.
In-Reply-To: <20020107230138.BBE15AE10@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33L.0201072112000.872-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Ed Tomlinson wrote:
> Rik van Riel wrote:
> > On Sun, 6 Jan 2002, Ed Tomlinson wrote:
> >
> >> This patch should prevent oom situations where the vm does not see
> >> pages released from the slab caches.
> >
> >> Comments?
> >
> > I have a feeling the OOM detection in rmap10c isn't working
> > out because of another issue ... I think it has something to
>
> I did not think this would solve all the OOM problems.  I do
> think it will improve the situation in some instances.

It certainly seems to work here, I'm including your patch
into rmap-11 ;)

> Hope your audit discloses other problems.

I haven't found any yet, the code seems ok even after
staring at it for an hour or so.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

