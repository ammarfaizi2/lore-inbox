Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276717AbRJJVoX>; Wed, 10 Oct 2001 17:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJJVoN>; Wed, 10 Oct 2001 17:44:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39690 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277419AbRJJVn7>; Wed, 10 Oct 2001 17:43:59 -0400
Date: Wed, 10 Oct 2001 18:44:13 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: <kernelnewbies@nl.linux.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT][PATCH] smoother VM for -ac
In-Reply-To: <Pine.LNX.4.33L.0110101815140.26495-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0110101842590.26495-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Rik van Riel wrote:
> On Wed, 10 Oct 2001, Benjamin LaHaise wrote:

> > There's a small problem with this one: I know that during
> > testing of earlier 2.4 kernels we saw a livelock which was
> > caused by the vm subsystem spinning without scheduling.

I added back the reschedule at the zone->pages_min() limit
and have documented this piece of black magic. New patch
can be found at:

	http://www.surriel.com/patches/

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/

