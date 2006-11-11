Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754878AbWKKWYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbWKKWYp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbWKKWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:24:44 -0500
Received: from mail1.coralwave.com ([24.244.175.138]:38921 "EHLO
	mail1.coralwave.com") by vger.kernel.org with ESMTP
	id S1754878AbWKKWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:24:44 -0500
From: Jason Harrison <jharrison@linuxbs.org>
To: Steve Langasek <vorlon@debian.org>
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Date: Sat, 11 Nov 2006 17:24:33 -0500
User-Agent: KMail/1.9.5
References: <20061102083718.GC12267@mauritius.dodds.net> <200611082104.37349.jharrison@linuxbs.org> <20061109055510.GH5314@mauritius.dodds.net>
In-Reply-To: <20061109055510.GH5314@mauritius.dodds.net>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111724.33284.jharrison@linuxbs.org>
X-IMAIL-SPAM-DNSBL: (v6net,4d9419fa01661af9,65.77.130.111)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I re-downloaded the patch and attempted to build patched 2.6.18.2 kernel 
sources.  The compile failed with some errors however.  The errors are below.

cc1: warnings being treated as errors
In file included from include/asm/core_titan.h:6,
                 from include/asm/io.h:250,
                 from include/linux/dmapool.h:14,
                 from include/linux/pci.h:564,
                 from arch/alpha/kernel/alpha_ksyms.c:16:
include/asm/pci.h:229: warning: 'enum pci_dma_burst_strategy' declared inside 
parameter list
include/asm/pci.h:229: warning: its scope is only this definition or 
declaration, which is probably not what you want
include/asm/pci.h: In function 'pci_dma_burst_advice':
include/asm/pci.h:240: error: dereferencing pointer to incomplete type
include/asm/pci.h:240: error: 'PCI_DMA_BURST_BOUNDARY' undeclared (first use 
in this function)
include/asm/pci.h:240: error: (Each undeclared identifier is reported only 
once
include/asm/pci.h:240: error: for each function it appears in.)
make[1]: *** [arch/alpha/kernel/alpha_ksyms.o] Error 1
make: *** [arch/alpha/kernel] Error 2

Hope this helps.

Regards,
Jason
