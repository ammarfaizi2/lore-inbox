Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266525AbUFZXef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266525AbUFZXef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267231AbUFZXef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:34:35 -0400
Received: from ozlabs.org ([203.10.76.45]:5811 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266525AbUFZXee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:34:34 -0400
Subject: Re: 2.6.7-bk: asm/setup.h and linux/init.h
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040626162429.4592cced.pj@sgi.com>
References: <20040626153511.A30532@flint.arm.linux.org.uk>
	 <Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>
	 <20040626174904.B30532@flint.arm.linux.org.uk>
	 <20040626162429.4592cced.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1088292861.3727.5.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 27 Jun 2004 09:34:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-27 at 09:24, Paul Jackson wrote:
> Could someone speak a few words on why a patch such as this is
> desirable?

Read Russell's original post; including asm-arm/setup.h from
linux/init.h enters #include hell.  It's purely a practical matter, and
while I agree with you in general on sizeof(), we need the constant
somewhere anyway to declare the array.

Hope that clarifies,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

