Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDDCTj>; Wed, 3 Apr 2002 21:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313090AbSDDCTa>; Wed, 3 Apr 2002 21:19:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45062 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313089AbSDDCTJ>; Wed, 3 Apr 2002 21:19:09 -0500
Date: Wed, 3 Apr 2002 22:14:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: kwijibo@zianet.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Small cosmetic fix for agpgart
In-Reply-To: <3CA995A8.1080604@zianet.com>
Message-ID: <Pine.LNX.4.21.0204032213490.9998-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Apr 2002 kwijibo@zianet.com wrote:

> Hi,
> 
> I didn't see any maintainer listed for agpgart, should this be
> jhartmann@precisioninsight.com?

In theory yes, but as far as I know he is not actively maintaining agpgart
anymore. 

There is no active maintainer.

> 
> Anyway, just a cosmetic fix that always bugged me.  
> The AMD 760 MP chipset was identified twice as AMD
> like so:
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Detected AMD AMD 760MP chipset
>                               ^^^^^^^^^^
> 
> This tiny patch will fix it so it appears as:
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 816M
> agpgart: Detected AMD 760MP chipset
> 
> Patch is against 2.4.18.

Thanks for the patch, applied.

