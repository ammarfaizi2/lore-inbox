Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275693AbRKHQex>; Thu, 8 Nov 2001 11:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275843AbRKHQen>; Thu, 8 Nov 2001 11:34:43 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:21510 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S275778AbRKHQec>; Thu, 8 Nov 2001 11:34:32 -0500
Date: Thu, 8 Nov 2001 14:34:08 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: out_of_memory() heuristic broken for different mem configurations
 (fwd)
In-Reply-To: <Pine.LNX.4.33.0111080805280.1480-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111081433120.27028-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Linus Torvalds wrote:
> On Thu, 8 Nov 2001, Marcelo Tosatti wrote:
> >
> > I guess you forgot to apply the following patch on 2.4.15-pre1, right ?
>
> The thing is, I _really_ think it is broken.
>
> The way to make it fail is to have many large SHARED mappings

ISTR that you wanted swap_out() changed into something which
only scans a portion of the ptes and doesn't have any return
value for a related reason in early 2.4 ... ;)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

