Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290431AbSAXWp6>; Thu, 24 Jan 2002 17:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290428AbSAXWpo>; Thu, 24 Jan 2002 17:45:44 -0500
Received: from svr3.applink.net ([206.50.88.3]:63240 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290430AbSAXWp3>;
	Thu, 24 Jan 2002 17:45:29 -0500
Message-Id: <200201242243.g0OMhAL06878@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Robert Love <rml@tech9.net>, timothy.covell@ashavan.org
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 16:44:38 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org> <200201242228.g0OMSlL06826@home.ashavan.org.> <1011911932.810.23.camel@phantasy>
In-Reply-To: <1011911932.810.23.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 16:38, Robert Love wrote:
> On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
> > On Thursday 24 January 2002 16:19, Robert Love wrote:
> > > how is "if (x)" any less legit if x is an integer ?
> >
> > What about
> >
> > {
> >     char x;
> >
> >     if ( x )
> >     {
> >         printf ("\n We got here\n");
> >     }
> >     else
> >     {
> >         // We never get here
> >         printf ("\n We never got here\n");
> >     }
> > }
> >
> >
> > That's not what I want.   It just seems too open to bugs
> > and messy IHMO.
>
> When would you ever use the above code?  Your reasoning is "you may
> accidentally check a char for a boolean value."  In other words, not
> realize it was a char.  What is to say its a boolean?  Or not?  This
> isn't an argument.  How does having a boolean type solve this?  Just use
> an int.
>
> 	Robert Love

It would fix this because then the compiler would refuse to compile
"if (x)"  when x is not a bool.    That's what I would call type safety.
But I guess that you all are arguing that C wasn't built that way and
that you don't want it.    

-- 
timothy.covell@ashavan.org.
