Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSEXVH1>; Fri, 24 May 2002 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSEXVH0>; Fri, 24 May 2002 17:07:26 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:13582 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S310190AbSEXVH0>; Fri, 24 May 2002 17:07:26 -0400
Date: Fri, 24 May 2002 23:07:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Russell King <rmk@arm.linux.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc,patch] breaking up sched.h
In-Reply-To: <20020524215249.C11638@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0205242301450.31145-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[lkml: sorry for double posting by mistake]

On Fri, 24 May 2002, Russell King wrote:

> The problem with linux/irq.h is that it makes many assumptions about the
> per-architecture irq code.  If anyone needs to include it (in its current
> form), then they're accessing architecture private data that may or may
> not be present.
> 
> Maybe the correct thing would be to move linux/irq.h to linux/hw_irq.h
> (so it matches asm/hw_irq.h) and move request_irq() and friends into a
> new linux/irq.h

Thank you.
I will do so in the sched.h cleanup patches that my heavy 
grepping will result in (I hope).

Tim

