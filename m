Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbRE3Sj4>; Wed, 30 May 2001 14:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261823AbRE3Sjq>; Wed, 30 May 2001 14:39:46 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49169 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261819AbRE3Sjh>;
	Wed, 30 May 2001 14:39:37 -0400
Date: Wed, 30 May 2001 15:39:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        Mike Galbraith <mikeg@wen-online.de>,
        Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <Pine.LNX.4.21.0105300913240.4783-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105301537150.12540-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Marcelo Tosatti wrote:

> The problem is that we allow _every_ task to age pages on the system
> at the same time --- this is one of the things which is fucking up.

This should not have any effect on the ratio of cache
reclaiming vs. swapout use, though...

> The another problem is that don't limit the writeout in the VM.

This is a big problem too, but also unrelated to the
impossibility of balancing cache vs. swap in the current
scheme.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

