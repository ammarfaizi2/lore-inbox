Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290673AbSARK7G>; Fri, 18 Jan 2002 05:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290663AbSARK6u>; Fri, 18 Jan 2002 05:58:50 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:3592 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290668AbSARK5c>; Fri, 18 Jan 2002 05:57:32 -0500
Date: Fri, 18 Jan 2002 10:57:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Combined APM patch
Message-ID: <20020118105724.A31497@flint.arm.linux.org.uk>
In-Reply-To: <1010762545.788.2.camel@thanatos> <20020111154016.D31366@flint.arm.linux.org.uk> <1011350629.1275.15.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1011350629.1275.15.camel@thanatos>; from jdthood@mail.com on Fri, Jan 18, 2002 at 05:43:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2002 at 05:43:48AM -0500, Thomas Hood wrote:
> On Fri, 2002-01-11 at 10:40, Russell King wrote:
> > On Fri, Jan 11, 2002 at 10:22:24AM -0500, Thomas Hood wrote:
> > > if someone later wants to modify the code to make
> > > this variable non-static, the comment tells that person that
> > > the variable will need an initializer.
> > 
> > Whether a variable is static or not doesn't change whether it ends up in
> > the bss segment or not.
> 
> It does make a difference if the variable definitions are inside
> a function; the non-static variable is on the stack and is not
> initialized to zero.

I should really ignore this mail, but, sigh.

I know this.  I was commenting on your code and the comment you made which,
in the context you were applying it, wasn't correct.

Hope this clears up the confusion.

> I understand that every static or top-level global variable
> is initialized to zero; but is it not useful to note when
> the code _relies upon_ this zero-initialization?  

Of course, I'm not disputing that.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

