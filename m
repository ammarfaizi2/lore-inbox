Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbREHJiV>; Tue, 8 May 2001 05:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbREHJiL>; Tue, 8 May 2001 05:38:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34827 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130820AbREHJh4>; Tue, 8 May 2001 05:37:56 -0400
Subject: Re: CML2 design philosophy heads-up
To: trini@kernel.crashing.org (Tom Rini)
Date: Mon, 7 May 2001 22:57:23 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010507105950.A771@opus.bloom.county> from "Tom Rini" at May 07, 2001 10:59:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wt0Q-00048P-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not all Mac's use the same SCSI controller
> 
> Yes, but in this case 'MAC' means m68k mac, which this _might_ be valid, but
> I never did get Linux up and running on the m68ks I had..

68K macs use the 53C80 and 53C9x controllers

> But Alan's point is a good one.  There are _lots_ of cases you can't get away
> with things like this, unless you get very fine grained.  In fact, it would
> be much eaiser to do this seperately from the kernel.  Ie another, 

There are also a lot of config options that are implied by your setup in
an embedded enviromment but which you dont actually want because you didnt
wire them

Second guessing is not ideal. As a 'make the default config nice' trick - great

