Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281451AbRKHEhe>; Wed, 7 Nov 2001 23:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281463AbRKHEhY>; Wed, 7 Nov 2001 23:37:24 -0500
Received: from guppy.vub.ac.be ([134.184.129.2]:23210 "EHLO guppy.vub.ac.be")
	by vger.kernel.org with ESMTP id <S281451AbRKHEhF>;
	Wed, 7 Nov 2001 23:37:05 -0500
Date: Thu, 8 Nov 2001 05:36:53 +0100 (CET)
From: Wouter Van Hemel <wouter@fort-knox.rave.org>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel compilation failure, 'deactivate_page'
In-Reply-To: <1228C3EC-D3FE-11D5-A423-00306569F1C6@haque.net>
Message-ID: <Pine.LNX.4.33.0111080530280.4723-100000@fort-knox.rave.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2001, Mohammad A. Haque wrote:

>
> On Wednesday, November 7, 2001, at 10:26 PM, Wouter Van Hemel wrote:
>
> >
> > I can't get the (clean) 2.4.14 kernel to compile. In the end, during
> > linking I guess, it fails with:
> >
> > [...]
> > drivers/block/block.o: In function `lo_send':
> > drivers/block/block.o(.text+0x854f): undefined reference to
> > `deactivate_page'
> > drivers/block/block.o(.text+0x8599): undefined reference to
> > `deactivate_page'
> > make: *** [vmlinux] Error 1
> >
> > And this is what happens before, while compiling loop.c:
> > loop.c: In function `lo_send':
> > loop.c:210: warning: implicit declaration of function `deactivate_page'
>
> Durn it wouter, you creating problems here too? =P
>

arghl... caught. :)

> http://marc.theaimsgroup.com/?l=linux-kernel&m=100502447823220&w=2
>

I did a search on www.uwsg.indiana.edu for 'deactivate_page', but nothing
turned up... Thanks. That simple, huh? Everything works fine after just
throwing that function out?


