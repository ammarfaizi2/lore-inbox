Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310501AbSCaBA1>; Sat, 30 Mar 2002 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310515AbSCaBAQ>; Sat, 30 Mar 2002 20:00:16 -0500
Received: from p017.as-l031.contactel.cz ([212.65.234.209]:4100 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S310501AbSCaBAF>;
	Sat, 30 Mar 2002 20:00:05 -0500
Date: Sun, 31 Mar 2002 01:46:28 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Denis Zaitsev <zzz@cd-club.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb_base.c - not a so little patch
Message-ID: <20020331004628.GB1552@ppc.vc.cvut.cz>
In-Reply-To: <2F43B06E5F@vcnet.vc.cvut.cz> <20020330214006.B1264@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2002 at 09:40:06PM +0500, Denis Zaitsev wrote:
> On Fri, Mar 22, 2002 at 01:17:04PM +0100, Petr Vandrovec wrote:
> > On 22 Mar 02 at 16:47, Denis Zaitsev wrote:
> > > 
> > > The patch is against 2.5.5.  It seems that matroxfb_base.c is still
> > > the same since that time.  And I assume matroxfb_base.c with
> > > <if (var->bits_per_pixel == 4)> branch present, i.e. without my
> > > previous little fix.
> > 
> > Did you verified effects on generated code/data size? 
> > 
> > > +   for (p= &table[0].bpp; *p < bpp; p+= sizeof table[0]);
> > > +   var->red   .offset= *++p; var->red   .length= *++p;
> > > +   var->green .offset= *++p; var->green .length= *++p;
> > > +   var->blue  .offset= *++p; var->blue  .length= *++p;
> > > +   var->transp.offset= *++p; var->transp.length= *++p;
> > 
> > Please no. Access fields by their names, and do not assume anything
> > about padding.
> >                                                 Petr Vandrovec
> >                                                 vandrove@vc.cvut.cz
> >                                                 
> 
> I'm sorry, Petr, why don't you answer anything to me?  I'd sent the
> cured patch a week ago...

What I should answer? Linus is not here, AFAIK, so patch sits on my
harddrive.
					Petr Vandrovec
					vandrove@vc.cvut.cz
