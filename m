Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbRE3S6R>; Wed, 30 May 2001 14:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbRE3S6H>; Wed, 30 May 2001 14:58:07 -0400
Received: from r109m208.cybercable.tm.fr ([195.132.109.208]:1296 "HELO
	alph.dyndns.org") by vger.kernel.org with SMTP id <S261835AbRE3S5x>;
	Wed, 30 May 2001 14:57:53 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: andrea@e-mind.com, Mark Hemment <markhe@veritas.com>,
        Jens Axboe <axboe@kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 30 May 2001 20:57:50 +0200
In-Reply-To: <Pine.LNX.4.21.0105301542210.12540-100000@imladris.rielhome.conectiva>
Message-ID: <87r8x6k6kx.fsf@mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Wed, 30 May 2001 andrea@e-mind.com wrote:
> 
> > btw, I think such heuristic is horribly broken ;), the highmem zone
> > simply needs to be balanced if it is under the pages_low mark, just
> > skipping it and falling back into the normal zone that happens to be
> > above the low mark is the wrong thing to do.
> 
> 2.3.51 did this, we all know the result.

Just a note, 
I remember the 2.3.51 kernel as the most usable kernel I ever used 
talking about VM.

-- 
Yoann Vandoorselaere | C makes it easy to shoot yourself in the foot. C++ makes
MandrakeSoft         | it harder, but when you do, it blows away your whole
                     | leg. - Bjarne Stroustrup
