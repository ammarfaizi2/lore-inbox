Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290417AbSAXWeX>; Thu, 24 Jan 2002 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290422AbSAXWeN>; Thu, 24 Jan 2002 17:34:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:28433 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290417AbSAXWeE>;
	Thu, 24 Jan 2002 17:34:04 -0500
Subject: Re: RFC: booleans and the kernel
From: Robert Love <rml@tech9.net>
To: timothy.covell@ashavan.org
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200201242228.g0OMSlL06826@home.ashavan.org.>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org>
	<200201242141.g0OLfjL06681@home.ashavan.org.>
	<1011910752.1012.19.camel@phantasy> 
	<200201242228.g0OMSlL06826@home.ashavan.org.>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 17:38:51 -0500
Message-Id: <1011911932.810.23.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 17:30, Timothy Covell wrote:
>
> On Thursday 24 January 2002 16:19, Robert Love wrote:
> > how is "if (x)" any less legit if x is an integer ?
>
> What about 
> 
> {
>     char x;
> 
>     if ( x )
>     {
>         printf ("\n We got here\n");
>     }
>     else
>     {
>         // We never get here
>         printf ("\n We never got here\n");
>     }
> }
> 
> 
> That's not what I want.   It just seems too open to bugs
> and messy IHMO.

When would you ever use the above code?  Your reasoning is "you may
accidentally check a char for a boolean value."  In other words, not
realize it was a char.  What is to say its a boolean?  Or not?  This
isn't an argument.  How does having a boolean type solve this?  Just use
an int.  

	Robert Love

