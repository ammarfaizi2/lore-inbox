Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWIDGOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWIDGOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 02:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWIDGOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 02:14:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:164 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751365AbWIDGOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 02:14:47 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Date: Mon, 4 Sep 2006 08:12:42 +0200
User-Agent: KMail/1.9.1
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, schwidefsky@de.ibm.com,
       heiko.carstens@de.ibm.com, uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040050.13410.alon.barlev@gmail.com> <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
In-Reply-To: <17659.26177.846522.226410@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040812.43553.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Under what circumstances do we actually need a command line of more
> than 256 bytes?

A common case is auto-installation of distributions. The auto installers
tends to get a lot of information passed using the kernel command line.

> It seems to me that if 256 bytes isn't enough, we should take a deep
> breath, step back, and think about whether there might be a better way
> to pass whatever information it is that's using up so much of the
> command line.

See it as the kernel's environment and it starts making more sense.
In theory another environment could be added, but then the command like
does the job already, except that it is a bit short sometimes. 

-Andi


-- 
VGER BF report: H 0
