Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbRE3Sgq>; Wed, 30 May 2001 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261812AbRE3Sgi>; Wed, 30 May 2001 14:36:38 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:38929 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261807AbRE3Sg1>;
	Wed, 30 May 2001 14:36:27 -0400
Date: Wed, 30 May 2001 15:36:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jens Axboe <axboe@kernel.org>
Cc: Mark Hemment <markhe@veritas.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, andrea@e-mind.com
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010530115538.B15089@suse.de>
Message-ID: <Pine.LNX.4.21.0105301534220.12540-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Jens Axboe wrote:

> You are right, this is definitely something that needs checking. I
> really want this to work though. Rik, Andrea? Will the balancing
> handle the extra zone?

In as far as it handles balancing the current zones,
it'll also work with one more. In places where it's
currently broken it will probably also break with one
extra zone, though the fact that the DMA32 zone takes
the pressure off the NORMAL zone might actually help.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

