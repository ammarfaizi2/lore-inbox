Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJTURt>; Sat, 20 Oct 2001 16:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRJTURj>; Sat, 20 Oct 2001 16:17:39 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23544
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S274299AbRJTURY>; Sat, 20 Oct 2001 16:17:24 -0400
Date: Sat, 20 Oct 2001 13:17:52 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: safemode <safemode@speakeasy.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swap with samba question using 2.4.12-ac3
Message-ID: <20011020131752.B31863@mikef-linux.matchmail.com>
Mail-Followup-To: safemode <safemode@speakeasy.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011020015841Z278715-17408+2574@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011020015841Z278715-17408+2574@vger.kernel.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 09:58:59PM -0400, safemode wrote:
> Ok, this is strange.   I'm stating about 3000 mp3s and they are on my linux 
> box on a samba share.  Now this is on a 100mbit network so it's going at 
> 4+MB/s.   I started compiling avifile and i noticed that my swap usage was at 
> 105MB.   Not sure how it got that way as most of my ram (660MB) is being used 
> as cache.   I'm not seeing any io so i'm guessing it's just mapped, not 
> actually being used. 
> 
> My real question is:   is it possible to just give the value of swap actually 
> being used as the swap use number? We have a breakdown of ram usage, but i 
> dont know of any breakdown of swap usage ( actual use vs. mapped).  It's just 
> a bit decieving when you glance at it and you see ram free 2MB swap use 105MB 
> but then you realize that 87% of your ram is still being used as cache so you 
> can't possibly be actually using 105MB of swap.   Heh.  smooth sailing though.

I think should be (SwapTotal - SwapFree - SwapCached) to get the ammount of
actually used swap.

Someone please let us know if I'm wrong.
