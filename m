Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289945AbSAKXis>; Fri, 11 Jan 2002 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290165AbSAKXii>; Fri, 11 Jan 2002 18:38:38 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:54287 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289945AbSAKXi0>;
	Fri, 11 Jan 2002 18:38:26 -0500
Date: Fri, 11 Jan 2002 21:38:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33.0201111609340.2580-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33L.0201112136140.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2002, Mark Hahn wrote:

> > overall performance seems far lower.  For instance, without the patch
> > the -j build finishes in ~10 minutes (2x933P3/256MB) but with the patch
>
> please, PLEASE stop using "make -j"
> for anything except the fork-bomb that it is.
> pretending that it's a benchmark, especially one
> to guide kernel tuning, is a travesty!

Actually, it's as good a benchmark as any. Knowing
how well the system is able to recover from heavy
overload situations is useful to know if your
server gets heavily overloaded at times.

If one VM falls over horribly under half the load
it takes to make another VM go slower, I know which
one I'd want on my server.

> if you want to simulate VM load, so something sane like
> boot with mem=32M, or a simple "mmap(lots); mlockall" tool.

... and then you come up with something WAY less
realistic than 'make -j' ;)))

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

