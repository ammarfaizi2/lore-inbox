Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131472AbRDFKhB>; Fri, 6 Apr 2001 06:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131476AbRDFKgu>; Fri, 6 Apr 2001 06:36:50 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:2482 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id <S131472AbRDFKgf>;
	Fri, 6 Apr 2001 06:36:35 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200104061035.MAA13189@sunrise.pg.gda.pl>
Subject: Re: Arch specific/multiple Configure.help files?
To: cate@debian.org
Date: Fri, 6 Apr 2001 12:35:13 +0200 (MET DST)
Cc: johan.adolfsson@axis.com (Johan Adolfsson), linux-kernel@vger.kernel.org
In-Reply-To: <3ACD8ECC.F2518B90@math.ethz.ch> from "Giacomo Catenazzi" at Apr 06, 2001 11:39:24 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Giacomo Catenazzi wrote:"
> Johan Adolfsson wrote:
> > 
> > Having the help close to the config sounds like a good idea
> > from a maintenance point of view.
> 
> But in 2.5.x the config.in are centralized, thus also
> Configure.help sould be centralized.
> And in this case I think that a big file hurts nobody.

What about common config options (like CONFIG_PCI, CONFIG_BINFMT_ELF,
CONFIG_SMP, CONFIG_SERIAL), which have Configure.help entries wtitten in
PC-centric style?

What is info about ISA/EISA bus for sparc users for? Why no info about SBUS
there?
What is COM3 for Amiga user?
How can alpha user compile kernel for Pentium?
What is the difference between ELF and A.OUT for architectures that do not
support a.out at all?

IMO some, even very standard, options may need different explanations for
different architectures.

Maybe some kind of architecture-specyfic #include in Configure.help entries?

Just my 0.03 PLZ

Andrzej
