Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSA2GhM>; Tue, 29 Jan 2002 01:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSA2Ggw>; Tue, 29 Jan 2002 01:36:52 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:26862 "EHLO fep7.cogeco.net")
	by vger.kernel.org with ESMTP id <S288801AbSA2Ggt>;
	Tue, 29 Jan 2002 01:36:49 -0500
Subject: Re: RFC: booleans and the kernel
From: "Nix N. Nix" <nix@go-nix.ca>
To: Kai Henningsen <kaih@khms.westfalen.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8HYG7RLmw-B@khms.westfalen.de>
In-Reply-To: <8HXjQ8omw-B@khms.westfalen.de>
	<1011911932.810.23.camel@phantasy>
	<200201242243.g0OMhAL06878@home.ashavan.org.>
	<8HXjQ8omw-B@khms.westfalen.de>
	<200201250900.g0P8xoL10082@home.ashavan.org.> 
	<8HYG7RLmw-B@khms.westfalen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 29 Jan 2002 01:36:47 -0500
Message-Id: <1012286208.16721.15.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 06:28, Thomas Hood wrote:
> Jeff Garzik wrote:
> > A small issue...
> 
> ... bound therefore to generate the most discussion ...
> 

:o)

Since we /are/ gorging ourselves in this C-reverie, I might as well:
...
> > int x=0;
> >
> > if ( x = 1 )

In my first-year C programming course, one of my more seasoned (and
phlegmatic) professors recommended that we get used to using 

if (1 == x)

instead of

if (x == 1)

so that, in case we /do/ miss the second '=', creating
(1 = x)
the compiler will puzzle over what exactly we mean by that and ask as
for advice in the form of something like "Error: lvalue required" (or
some such), an error, in any case.



Just comes to mind.
...
> 
> MfG Kai
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


