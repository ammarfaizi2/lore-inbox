Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbRE3S42>; Wed, 30 May 2001 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbRE3S4S>; Wed, 30 May 2001 14:56:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9481 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261735AbRE3S4D>; Wed, 30 May 2001 14:56:03 -0400
Date: Wed, 30 May 2001 14:19:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        Mike Galbraith <mikeg@wen-online.de>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.21.0105301537150.12540-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105301417510.5231-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 May 2001, Rik van Riel wrote:

> On Wed, 30 May 2001, Marcelo Tosatti wrote:
> 
> > The problem is that we allow _every_ task to age pages on the system
> > at the same time --- this is one of the things which is fucking up.
> 
> This should not have any effect on the ratio of cache
> reclaiming vs. swapout use, though...

Sure, who said that ? :) 

The current discussion between Mike/Jonathan and me is about the aging
issue.

> 
> > The another problem is that don't limit the writeout in the VM.
> 
> This is a big problem too, but also unrelated to the
> impossibility of balancing cache vs. swap in the current
> scheme.

... 


