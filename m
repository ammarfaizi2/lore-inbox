Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290440AbSAXWtN>; Thu, 24 Jan 2002 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290436AbSAXWtF>; Thu, 24 Jan 2002 17:49:05 -0500
Received: from svr3.applink.net ([206.50.88.3]:5897 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290438AbSAXWss>;
	Thu, 24 Jan 2002 17:48:48 -0500
Message-Id: <200201242246.g0OMkML06890@home.ashavan.org.>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Xavier Bestel <xavier.bestel@free.fr>, timothy.covell@ashavan.org
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 16:47:50 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org> <200201242123.g0OLNAL06617@home.ashavan.org.> <1011911622.2631.6.camel@bip>
In-Reply-To: <1011911622.2631.6.camel@bip>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 16:33, Xavier Bestel wrote:
> le ven 25-01-2002 à 22:24, Timothy Covell a écrit :
> > On Thursday 24 January 2002 14:39, Oliver Xymoron wrote:
> > > The compiler _will_ turn if(a==0) into a test of a with itself rather
> > > than a comparison against a constant. Since PDP days, no doubt.
> >
> > I thought that the whole point of booleans was to stop silly errors
> > like
> >
> > if ( x = 1 )
> > {
> > 	printf ("\nX is true\n");
> > }
> > else
> > {
> > 	// we never get here...
> > }
>
> gcc already warns you about such errors.
>
> 	Xav

That's funny, I compiled it with "gcc -Wall foo.c" and got no
warnings.    Please show me what I'm doing wrong and how
it's _my_ mistake and not the compilers.

-- 
timothy.covell@ashavan.org.
