Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHXDmL>; Fri, 23 Aug 2002 23:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315337AbSHXDmL>; Fri, 23 Aug 2002 23:42:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47626 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315282AbSHXDmK>; Fri, 23 Aug 2002 23:42:10 -0400
Date: Sat, 24 Aug 2002 00:46:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marc-Christian Petersen <m.c.p@gmx.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 kernel series and the oom_killer and /proc/sys/vm/overcommit_memory
In-Reply-To: <E17iQL2-0001VV-00@starship>
Message-ID: <Pine.LNX.4.44L.0208240045310.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Aug 2002, Daniel Phillips wrote:
> On Thursday 22 August 2002 19:32, Alan Cox wrote:
> > 3 is a totally paranoid [overcommit policy] that will require everything in
> > ram can be dumped to swap or paged back from backing store
>
> How do you handle the situation where you have a lot of shared memory in a
> half-paged-out state, so that each shared page consumes both ram and swap?

That will work fine with 'totally paranoid' mode.  There is always
enough swap space to hold _all_ pages, so everything will just
continue to work.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

