Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313501AbSC3Qkm>; Sat, 30 Mar 2002 11:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313502AbSC3Qkc>; Sat, 30 Mar 2002 11:40:32 -0500
Received: from [212.57.170.162] ([212.57.170.162]:2828 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S313501AbSC3QkY>;
	Sat, 30 Mar 2002 11:40:24 -0500
Date: Sat, 30 Mar 2002 21:40:06 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb_base.c - not a so little patch
Message-ID: <20020330214006.B1264@natasha.zzz.zzz>
In-Reply-To: <2F43B06E5F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 01:17:04PM +0100, Petr Vandrovec wrote:
> On 22 Mar 02 at 16:47, Denis Zaitsev wrote:
> > 
> > The patch is against 2.5.5.  It seems that matroxfb_base.c is still
> > the same since that time.  And I assume matroxfb_base.c with
> > <if (var->bits_per_pixel == 4)> branch present, i.e. without my
> > previous little fix.
> 
> Did you verified effects on generated code/data size? 
> 
> > +   for (p= &table[0].bpp; *p < bpp; p+= sizeof table[0]);
> > +   var->red   .offset= *++p; var->red   .length= *++p;
> > +   var->green .offset= *++p; var->green .length= *++p;
> > +   var->blue  .offset= *++p; var->blue  .length= *++p;
> > +   var->transp.offset= *++p; var->transp.length= *++p;
> 
> Please no. Access fields by their names, and do not assume anything
> about padding.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 

I'm sorry, Petr, why don't you answer anything to me?  I'd sent the
cured patch a week ago...
