Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289677AbSAXTxI>; Thu, 24 Jan 2002 14:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289872AbSAXTws>; Thu, 24 Jan 2002 14:52:48 -0500
Received: from waste.org ([209.173.204.2]:22177 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S289677AbSAXTwi>;
	Thu, 24 Jan 2002 14:52:38 -0500
Date: Thu, 24 Jan 2002 13:52:23 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0201241313420.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Jeff Garzik wrote:

> A small issue...
>
> C99 introduced _Bool as a builtin type.  The gcc patch for it went into
> cvs around Dec 2000.  Any objections to propagating this type and usage
> of 'true' and 'false' around the kernel?

Ugh, no. C doesn't need booleans, neither do Perl or Python. This is a
sickness imported from _recent_ C++ by way of Java by way of Pascal. This
just complicates things.

> Where variables are truly boolean use of a bool type makes the
> intentions of the code more clear.  And it also gives the compiler a
> slightly better chance to optimize code [I suspect].

Unlikely. The compiler can already figure this sort of thing out from
context.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

