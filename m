Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTJYU1x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 16:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbTJYU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 16:27:53 -0400
Received: from ns.suse.de ([195.135.220.2]:31902 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262797AbTJYU1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 16:27:51 -0400
Date: Sat, 25 Oct 2003 22:27:50 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [AMD64 1/3] fix C99-style declarations
Message-ID: <20031025202750.GC27754@wotan.suse.de>
References: <20031025182824.GA12117@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025182824.GA12117@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 02:28:24PM -0400, Jeff Garzik wrote:
> 
> Although the compiler has always supposed C99 style, I feel that until
> the kernel as a whole moves to C99 style, such code reduces portability
> to other compilers.  In particular, I am willing to bet Intel's Yamhill
> will eventually be supported by the x86-64 code, and non-gcc compilers
> will eventually be used to build this platform.

The intel compiler supports C99 just fine.

x86-64 always used C99 and there is no x86-64 compiler 
around that doesn't support it. I must say I was somewhat pissed off
that someone added that nasty warning to the toplevel Makefile
just to comfort some gcc 2.95 users on i386 ("all world is a i386")

I have enough trouble just to get the essential bug/compilefixes accepted
by Linus, so I see no chance to get such things in currently.

-Andi
