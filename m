Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270473AbRHHMVB>; Wed, 8 Aug 2001 08:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270475AbRHHMUm>; Wed, 8 Aug 2001 08:20:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2323 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270473AbRHHMU1>; Wed, 8 Aug 2001 08:20:27 -0400
Date: Wed, 8 Aug 2001 09:20:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] total_free_shortage() using zone_free_shortage()
In-Reply-To: <Pine.LNX.4.33.0108080020120.923-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108080919420.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Linus Torvalds wrote:

> Right. We want the free target to obviously be larger than the low target,
> to avoid hysteresis around it.  And at the same time the free target
> obviously has to be smaller than the more-than-enough "plenty" case.

This should, indeed, make the balancing between the zones
work as planned. In theory.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

