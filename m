Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291218AbSBLWRL>; Tue, 12 Feb 2002 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291215AbSBLWRB>; Tue, 12 Feb 2002 17:17:01 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:15116 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291218AbSBLWQu>;
	Tue, 12 Feb 2002 17:16:50 -0500
Date: Tue, 12 Feb 2002 20:16:40 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: File BlockSize
In-Reply-To: <E16alMy-0003GH-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0202122016210.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Alan Cox wrote:

> > > This sounds like fairly severe memory fragmentation, which seems more
> > > worrisome to me than blocksize constraints. Should I look into that?
> >
> > Sorry for being dense, but I don't see why an 8 kB block would
> > need to occupy 2 contiguous pages in ram.
>
> Because all the kernel code knows that you can add a constant to the
> base of a buffer to get anywhere in that block. Also the one buffer
> per two page case isnt handled either

Is this still the case after blkdev-in-pagecache ?

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

