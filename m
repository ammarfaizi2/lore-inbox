Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRGGVpi>; Sat, 7 Jul 2001 17:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266588AbRGGVpS>; Sat, 7 Jul 2001 17:45:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:22791 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266582AbRGGVpG>; Sat, 7 Jul 2001 17:45:06 -0400
Date: Sat, 7 Jul 2001 18:45:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <E15Izr0-0006Hy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0107071844470.1389-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2001, Alan Cox wrote:

> > > Its certainly misleading. I got Jeff to try making oom return
> > > 4999 out of 5000 times regardless.
> >
> > In that case, he _is_ OOM.  ;)
>
> Hardly
>
> > 1) (almost) no free memory
> > 2) no free swap
> > 3) very little pagecache + buffer cache
>
> Large amounts of cache, which went away when the OOM code was neutered

So Jeff backed out my patch before testing yours? ;)

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

