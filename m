Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290378AbSAXWbX>; Thu, 24 Jan 2002 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290413AbSAXWbP>; Thu, 24 Jan 2002 17:31:15 -0500
Received: from svr3.applink.net ([206.50.88.3]:45832 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S290382AbSAXWbJ>;
	Thu, 24 Jan 2002 17:31:09 -0500
Message-Id: <200201242228.g0OMSlL06826@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Robert Love <rml@tech9.net>, timothy.covell@ashavan.org
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 16:30:15 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org> <200201242141.g0OLfjL06681@home.ashavan.org.> <1011910752.1012.19.camel@phantasy>
In-Reply-To: <1011910752.1012.19.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 16:19, Robert Love wrote:
> On Fri, 2002-01-25 at 16:43, Timothy Covell wrote:
> > It doesn't fix  "if ( x = true)". If would
> > just make it more legit to use "if (x)".
> > Just IMHO.
>
> how is "if (x)" any less legit if x is an integer ?
>
> 	Robert Love
>

What about 

{
    char x;

    if ( x )
    {
        printf ("\n We got here\n");
    }
    else
    {
        // We never get here
        printf ("\n We never got here\n");
    }
}


That's not what I want.   It just seems too open to bugs
and messy IHMO.

-- 
timothy.covell@ashavan.org.
