Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290102AbSAXUGt>; Thu, 24 Jan 2002 15:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290063AbSAXUGj>; Thu, 24 Jan 2002 15:06:39 -0500
Received: from waste.org ([209.173.204.2]:1186 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290102AbSAXUG0>;
	Thu, 24 Jan 2002 15:06:26 -0500
Date: Thu, 24 Jan 2002 14:06:23 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <3C50688B.E87B421F@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0201241404520.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Jeff Garzik wrote:

> Oliver Xymoron wrote:
> > On Thu, 24 Jan 2002, Jeff Garzik wrote:
> > > Where variables are truly boolean use of a bool type makes the
> > > intentions of the code more clear.  And it also gives the compiler a
> > > slightly better chance to optimize code [I suspect].
> >
> > Unlikely. The compiler can already figure this sort of thing out from
> > context.
>
> X, true, and false are of type int.
> If one tests X==false and then later on tests X==true, how does the
> compiler know the entire domain has been tested?

Because you never test against X==true. You always test X!=false. This is
the C way.

> Or a switch statement... if both true and false are covered,
> there is no need for a 'default'.

Your cases are false and default.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

