Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281944AbRKUSw2>; Wed, 21 Nov 2001 13:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281932AbRKUSwI>; Wed, 21 Nov 2001 13:52:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46602 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281451AbRKUSwE>; Wed, 21 Nov 2001 13:52:04 -0500
Date: Wed, 21 Nov 2001 16:51:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: george anzinger <george@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Memory allocation question
In-Reply-To: <3BFBF6A4.6F1472C6@mvista.com>
Message-ID: <Pine.LNX.4.33L.0111211651280.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, george anzinger wrote:
> Alan Cox wrote:
> >
> > > size chuncks.  Currently I am using kmalloc() to allocate a page at a
> > > time.  I don't want to have to worry about mapping/unmapping etc.  I
> >
> > Use get_free_page() to get page sized chunks
>
> What about __get_free_page() ?  I don't need or want the clear page
> (performance issues).

get_free_page() doesn't clear the page afaics.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

