Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUAVXju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 18:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUAVXju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 18:39:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:27073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265144AbUAVXjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 18:39:47 -0500
Date: Thu, 22 Jan 2004 15:39:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: Valdis.Kletnieks@vt.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5 versus gcc 3.5 snapshot
In-Reply-To: <20040122233016.GA21967@twiddle.net>
Message-ID: <Pine.LNX.4.58.0401221538030.2998@home.osdl.org>
References: <200401212236.i0LMaNuh020491@turing-police.cc.vt.edu>
 <Pine.LNX.4.58.0401212043200.2123@home.osdl.org> <20040122060253.GA18719@twiddle.net>
 <Pine.LNX.4.58.0401220725180.2123@home.osdl.org> <20040122233016.GA21967@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jan 2004, Richard Henderson wrote:
> On Thu, Jan 22, 2004 at 07:27:52AM -0800, Linus Torvalds wrote:
> > Shorthand or not, the "+m" usage is (a) totally logical
> 
> Logical or not, "+" is not how reload works; this must be split to use "0".

Why don't you split it to do "m" instead?

> > Please fix the compiler.
> 
> Maybe someday, but not I'm not rewriting reload today.  Given there *is*
> an alternative way to write this, it is definitely not a priority.

The point being:
 - it's documented
 - it is used
 - you don't have to fix reload, just the splitting

So why break it? Just do the alternative as the split, since you say it is 
equivalent anyway.

		Linus
