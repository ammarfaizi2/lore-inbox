Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290444AbSAXWyx>; Thu, 24 Jan 2002 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290261AbSAXWyo>; Thu, 24 Jan 2002 17:54:44 -0500
Received: from AMontpellier-201-1-1-52.abo.wanadoo.fr ([193.252.31.52]:63237
	"EHLO awak") by vger.kernel.org with ESMTP id <S290448AbSAXWyd> convert rfc822-to-8bit;
	Thu, 24 Jan 2002 17:54:33 -0500
Subject: Re: RFC: booleans and the kernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: timothy.covell@ashavan.org
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200201242246.g0OMkML06890@home.ashavan.org.>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org>
	<200201242123.g0OLNAL06617@home.ashavan.org.> <1011911622.2631.6.camel@bip>
	 <200201242246.g0OMkML06890@home.ashavan.org.>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 24 Jan 2002 23:53:46 +0100
Message-Id: <1011912826.2258.10.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 25-01-2002 à 23:47, Timothy Covell a écrit :
> On Thursday 24 January 2002 16:33, Xavier Bestel wrote:
> > le ven 25-01-2002 à 22:24, Timothy Covell a écrit :
> > > On Thursday 24 January 2002 14:39, Oliver Xymoron wrote:
> > > > The compiler _will_ turn if(a==0) into a test of a with itself rather
> > > > than a comparison against a constant. Since PDP days, no doubt.
> > >
> > > I thought that the whole point of booleans was to stop silly errors
> > > like
> > >
> > > if ( x = 1 )
> > > {
> > > 	printf ("\nX is true\n");
> > > }
> > > else
> > > {
> > > 	// we never get here...
> > > }
> >
> > gcc already warns you about such errors.
> >
> > 	Xav
> 
> That's funny, I compiled it with "gcc -Wall foo.c" and got no
> warnings.    Please show me what I'm doing wrong and how
> it's _my_ mistake and not the compilers.

[xav@bip:~]$ gcc -Wall a.c
a.c: In function `main':
a.c:8: warning: suggest parentheses around assignment used as truth value

	Xav

