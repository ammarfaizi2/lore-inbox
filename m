Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSEFOBB>; Mon, 6 May 2002 10:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314444AbSEFOBA>; Mon, 6 May 2002 10:01:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40206 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314417AbSEFOBA>; Mon, 6 May 2002 10:01:00 -0400
Date: Mon, 6 May 2002 11:00:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: bert hubert <ahu@ds9a.nl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.14..
In-Reply-To: <3CD62BAE.BABF3831@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0205061100030.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Andrew Morton wrote:
> bert hubert wrote:

> > I parsed this 'dirty state' sentence all wrong at first :-) Andrew, Linus -
> > where does the current VM lie in between rmap-vm and aa-vm?

> I made minimal changes in there to teach the page allocator that
> all dirty memory is written back via pages and not sometimes-pages,
> sometimes-buffers.  Also to add support for the new `clustering
> writeback' which address_spaces can perform.

> So it's all page-oriented now.

Nice, this will make it possible to have much cleaner page
replacement code.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

