Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTJYUrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTJYUrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:47:19 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:15633 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262794AbTJYUrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:47:18 -0400
Date: Sat, 25 Oct 2003 21:47:17 +0100
From: John Levon <levon@movementarian.org>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031025204717.GA78345@compsoc.man.ac.uk>
References: <20031025182824.GA12117@gtf.org> <20031025202750.GC27754@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025202750.GC27754@wotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ADVJd-000HlC-EE*rDAeP.8/0tQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 10:27:50PM +0200, Andi Kleen wrote:

> x86-64 always used C99 and there is no x86-64 compiler 
> around that doesn't support it. I must say I was somewhat pissed off
> that someone added that nasty warning to the toplevel Makefile
> just to comfort some gcc 2.95 users on i386 ("all world is a i386")

Sorry, that is bullshit. The change was entirely designed to prevent
people on such architectures hacking general files where there *do*
exist older compilers, to avoid breakage being introduced without it
being flagged.

This has happened more than once in the tree.

When all the architectures have a minimum gcc requirement that accepts
mixed code and declarations by default, it can be removed ...

regards,
john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
