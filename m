Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316796AbSEVAKn>; Tue, 21 May 2002 20:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSEVAKn>; Tue, 21 May 2002 20:10:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37392 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316796AbSEVAKl>; Tue, 21 May 2002 20:10:41 -0400
Date: Tue, 21 May 2002 17:10:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <3CEAD9AF.9F6FD0FC@linux-m68k.org>
Message-ID: <Pine.LNX.4.44.0205211709300.3589-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Roman Zippel wrote:
>
> Alternative suggestion: remove the present bit from the pgd/pmd entry.
> After you flushed the tlb, you can clean up the page tables without a
> hurry. That will work on any sane system and you don't have to force
> data and table pages into the same interface.

Sounds sane, except for the fact that some architectures do not actually
care about the "Present" bit in the pgd at all.

x86, to be exact ;(

		Linus

