Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316800AbSEVAb7>; Tue, 21 May 2002 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316802AbSEVAb6>; Tue, 21 May 2002 20:31:58 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39182 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316800AbSEVAb6>; Tue, 21 May 2002 20:31:58 -0400
Date: Wed, 22 May 2002 02:31:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <Pine.LNX.4.44.0205211709300.3589-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205220227280.23394-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 21 May 2002, Linus Torvalds wrote:

> > Alternative suggestion: remove the present bit from the pgd/pmd entry.
> > After you flushed the tlb, you can clean up the page tables without a
> > hurry. That will work on any sane system and you don't have to force
> > data and table pages into the same interface.
> 
> Sounds sane, except for the fact that some architectures do not actually
> care about the "Present" bit in the pgd at all.
> 
> x86, to be exact ;(

IMO that's not really problem, the pmd tables are created and destroyed
with the pgd table.

bye, Roman

