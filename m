Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286346AbRLJST2>; Mon, 10 Dec 2001 13:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286347AbRLJSTT>; Mon, 10 Dec 2001 13:19:19 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46866 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286341AbRLJSSS>; Mon, 10 Dec 2001 13:18:18 -0500
Date: Mon, 10 Dec 2001 16:17:56 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <volodya@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.20.0112101307360.18115-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33L.0112101617300.4755-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> On Mon, 10 Dec 2001, Rik van Riel wrote:

> > Even if you have a handle on a physical page, you don't know
> > what processes are using the page, nor if there are additional
> > users besides the processes.
>
> Well, what does kernel do when it runs out of memory ? For example
> when I mmap a large file and start reading it back and force ?

For the full horror, see mm/vmscan.c, do_try_to_free_memory()

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

