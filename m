Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266573AbRGGV36>; Sat, 7 Jul 2001 17:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGGV3s>; Sat, 7 Jul 2001 17:29:48 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:38150 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266573AbRGGV3d>; Sat, 7 Jul 2001 17:29:33 -0400
Date: Sat, 7 Jul 2001 18:29:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <E15Iza0-0006GJ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0107071828500.1389-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jul 2001, Alan Cox wrote:

> > instead. That way the vmstat output might be more useful, although vmstat
> > obviously won't know about the new "SwapCache:" field..
> >
> > Can you try that, and see if something else stands out once the misleading
> > accounting is taken care of?
>
> Its certainly misleading. I got Jeff to try making oom return
> 4999 out of 5000 times regardless.

In that case, he _is_ OOM.  ;)

1) (almost) no free memory
2) no free swap
3) very little pagecache + buffer cache

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

