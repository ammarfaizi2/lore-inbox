Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSGXAT2>; Tue, 23 Jul 2002 20:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSGXAT2>; Tue, 23 Jul 2002 20:19:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:32274 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S315628AbSGXAT1>; Tue, 23 Jul 2002 20:19:27 -0400
Date: Tue, 23 Jul 2002 21:21:35 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Austin Gonyou <austin@digitalroadkill.net>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       David Rees <dbr@greenhydrant.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19rc2aa1 VM too aggressive?
In-Reply-To: <20020723235254.GB1117@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207232121130.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Andrea Arcangeli wrote:
> On Fri, Jul 19, 2002 at 09:07:07PM -0300, Rik van Riel wrote:
> > On 19 Jul 2002, Austin Gonyou wrote:
> >
> > > Notice you're memory utilization jumps here as your free is given to
> > > cache.
> >
> > Swinging back and forth 150 MB per second seems a bit excessive
> > for that, especially considering that the previously cached
> > memory seems to end up on the free list and the fact that there
> > is between 350 and 500 MB free memory.
>
> if the app allocates and frees 150MB of shm per second that's what the
> kernel has to show you.

Indeed, though I have to comment that that's rather interesting
web server software ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

