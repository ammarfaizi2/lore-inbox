Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290355AbSAXVov>; Thu, 24 Jan 2002 16:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290345AbSAXVol>; Thu, 24 Jan 2002 16:44:41 -0500
Received: from svr3.applink.net ([206.50.88.3]:52999 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290321AbSAXVoX>;
	Thu, 24 Jan 2002 16:44:23 -0500
Message-Id: <200201242141.g0OLfjL06681@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Oliver Xymoron <oxymoron@waste.org>,
        Timothy Covell <timothy.covell@ashavan.org>
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 15:43:14 -0600
X-Mailer: KMail [version 1.3.2]
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 15:31, Oliver Xymoron wrote:
> On Fri, 25 Jan 2002, Timothy Covell wrote:
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
> > 	# we never get here...
> > }
>
> And how does s/1/true/ fix that?

It doesn't fix  "if ( x = true)". If would
just make it more legit to use "if (x)".
Just IMHO.

-- 
timothy.covell@ashavan.org.
