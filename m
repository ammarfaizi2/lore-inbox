Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290604AbSAYIki>; Fri, 25 Jan 2002 03:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290606AbSAYIk2>; Fri, 25 Jan 2002 03:40:28 -0500
Received: from khms.westfalen.de ([62.153.201.243]:15546 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S290605AbSAYIkO>; Fri, 25 Jan 2002 03:40:14 -0500
Date: 25 Jan 2002 08:36:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8HXjQ8omw-B@khms.westfalen.de>
In-Reply-To: <200201242243.g0OMhAL06878@home.ashavan.org.>
Subject: Re: RFC: booleans and the kernel
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <1011911932.810.23.camel@phantasy> <Pine.LNX.4.44.0201241530000.2839-100000@waste.org> <200201242228.g0OMSlL06826@home.ashavan.org.> <1011911932.810.23.camel@phantasy> <200201242243.g0OMhAL06878@home.ashavan.org.>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timothy.covell@ashavan.org (Timothy Covell)  wrote on 25.01.02 in <200201242243.g0OMhAL06878@home.ashavan.org.>:

> On Thursday 24 January 2002 16:38, Robert Love wrote:
> > On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
> > > On Thursday 24 January 2002 16:19, Robert Love wrote:
> > > > how is "if (x)" any less legit if x is an integer ?
> > >
> > > What about
> > >
> > > {
> > >     char x;
> > >
> > >     if ( x )
> > >     {
> > >         printf ("\n We got here\n");
> > >     }
> > >     else
> > >     {
> > >         // We never get here
> > >         printf ("\n We never got here\n");
> > >     }
> > > }
> > >
> > >
> > > That's not what I want.   It just seems too open to bugs
> > > and messy IHMO.
> >
> > When would you ever use the above code?  Your reasoning is "you may
> > accidentally check a char for a boolean value."  In other words, not
> > realize it was a char.  What is to say its a boolean?  Or not?  This
> > isn't an argument.  How does having a boolean type solve this?  Just use
> > an int.
> >
> > 	Robert Love
>
> It would fix this because then the compiler would refuse to compile
> "if (x)"  when x is not a bool.    That's what I would call type safety.

But that's not what C actually does.

> But I guess that you all are arguing that C wasn't built that way and
> that you don't want it.

We're talking about a specific language feature, and that feature isn't  
what you seem to be thinking it is. It does not change anything you can do  
with ints.


MfG Kai
