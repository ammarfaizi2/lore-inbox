Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUJCIdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUJCIdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 04:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUJCIde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 04:33:34 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:8885 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267765AbUJCIdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 04:33:32 -0400
Date: Sun, 3 Oct 2004 10:30:14 +0200
To: Adrian Bunk <adrian.bunk@stusta.de>, Ed Tomlinson <edt@aei.ca>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 build failure
Message-ID: <20041003083014.GB12458@gamma.logic.tuwien.ac.at>
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <200410021440.45194.edt@aei.ca> <1096787657.9182.6.camel@localhost> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <200410021440.45194.edt@aei.ca> <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <20041002105038.GB2470@stusta.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1096787657.9182.6.camel@localhost> <200410021440.45194.edt@aei.ca> <20041002105038.GB2470@stusta.mhn.de>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sam, 02 Okt 2004, Adrian Bunk wrote:
> > See if arch/i386/kernel/io_apic.c needs
> 
> s/io_apic.c/irq.c/ and it should solve Norberts problem.
> 
> > #include <asm/io_apic.h>

Thanks Adrian! Your two fixes definitely fixed the problem.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CAARNDUNCAN (n.)
The high-pitched and insistent cry of the young female human urging
one of its peer group to do something dangerous on a cliff-edge or
piece of toxic waste ground.
			--- Douglas Adams, The Meaning of Liff
