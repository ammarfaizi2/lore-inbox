Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbRGFWQ4>; Fri, 6 Jul 2001 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266691AbRGFWQq>; Fri, 6 Jul 2001 18:16:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45325 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265575AbRGFWQk>; Fri, 6 Jul 2001 18:16:40 -0400
Date: Fri, 6 Jul 2001 19:16:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OOM kill trigger fix
In-Reply-To: <Pine.LNX.4.21.0107062256440.4167-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0107061916230.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Hugh Dickins wrote:
> On Fri, 6 Jul 2001, Rik van Riel wrote:
> >
> > Of course, to implement this we have to count the number of
> > swapcache pages, but that's a 2-liner ;)
>
> swapper_space.nrpages already counts that (as Andrea once
> pointed out), no need to add your nr_swapcache_pages.

Whoops, indeed...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

