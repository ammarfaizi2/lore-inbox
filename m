Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290324AbSAXVcV>; Thu, 24 Jan 2002 16:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290323AbSAXVcF>; Thu, 24 Jan 2002 16:32:05 -0500
Received: from waste.org ([209.173.204.2]:6824 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290324AbSAXVbr>;
	Thu, 24 Jan 2002 16:31:47 -0500
Date: Thu, 24 Jan 2002 15:31:34 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <200201242123.g0OLNAL06617@home.ashavan.org.>
Message-ID: <Pine.LNX.4.44.0201241530000.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Timothy Covell wrote:

> On Thursday 24 January 2002 14:39, Oliver Xymoron wrote:
> >
> > The compiler _will_ turn if(a==0) into a test of a with itself rather than
> > a comparison against a constant. Since PDP days, no doubt.
>
> I thought that the whole point of booleans was to stop silly errors
> like
>
> if ( x = 1 )
> {
> 	printf ("\nX is true\n");
> }
> else
> {
> 	# we never get here...
> }

And how does s/1/true/ fix that?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

