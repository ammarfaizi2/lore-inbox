Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263796AbREYQ2n>; Fri, 25 May 2001 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbREYQ2e>; Fri, 25 May 2001 12:28:34 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53263 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263796AbREYQ2S>; Fri, 25 May 2001 12:28:18 -0400
Subject: Re: 2.4 freezes on VIA KT133
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Fri, 25 May 2001 17:22:06 +0100 (BST)
Cc: hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        trip@matrix.cyberspace.cz (Tomas Styblo), linux-kernel@vger.kernel.org
In-Reply-To: <200105250505.f4P555c451210@saturn.cs.uml.edu> from "Albert D. Cahalan" at May 25, 2001 01:05:05 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153KLm-0006l1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> VIA hardware is not suitable for anything until we _know_ the
> truth about what is wrong. VIA is hiding something big.

I dont think thats true

> Creative Labs ought to toast VIA over blaming the sound card. :-)

Of course the card might be buggy too

The big problem with VIA is not that their hardware has bugs. Everyone has
bugs. I can get a problem with an intel chipset go to developer.intel.com and
generally get a straight answer and often a workaround. That makes me happy.
The problem isnt the bug, its not being given honest info on it.

If VIA had public errata that said things like 'Prefetch bursts can cause
problems unless you set bit 3 of blah' well we'd be able to evaluate the 
performance impacts and people could make sensible decisions and have 
reliable code.

Intel are not perfect either. We have a whole pile of laptops that crash when
speedstep triggers a trap we cannot handle. We have an APIC problem that took
much effort because they refused to help.

When vendors do help life gets a lot easier. AMD USB was a problem due to 
errata. Once they published the fixes AMD USB ceased to be a problem. 

Alan

