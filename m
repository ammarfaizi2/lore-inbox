Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315603AbSETAeC>; Sun, 19 May 2002 20:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSETAeB>; Sun, 19 May 2002 20:34:01 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:9479 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315603AbSETAeA>; Sun, 19 May 2002 20:34:00 -0400
Date: Mon, 20 May 2002 02:33:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205200211380.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 18 May 2002, Linus Torvalds wrote:

> The TLB invalidate rewrite will likely have broken all other architectures 
> (at least performance-wise, if not in any other way), so architecture 
> maintainers look out!

Two questions about asm-generic/tlb.h:
- freed is never incremented, callers of tlb_remove_page have to do the
  rss update themselves?
- will a non smp version later be added again?

bye, Roman

