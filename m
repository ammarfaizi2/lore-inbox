Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318924AbSH1TY4>; Wed, 28 Aug 2002 15:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318925AbSH1TY4>; Wed, 28 Aug 2002 15:24:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:40710 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S318924AbSH1TYy>; Wed, 28 Aug 2002 15:24:54 -0400
Date: Wed, 28 Aug 2002 21:29:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Matthew Dobson <colpatch@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Martin Bligh <mjbligh@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] SImple Topology API v0.3 (1/2)
Message-ID: <20020828192917.GC10487@atrey.karlin.mff.cuni.cz>
References: <20020827143115.B39@toy.ucw.cz> <Pine.LNX.4.44.0208280711390.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208280711390.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > -   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
> > > +   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
> > 
> > Why not simply CONFIG_NUMA?
> 
> Because NUMA is subordinate to X86, and another technology named NUMA 
> might appear? Nano-uplinked micro-array... No Ugliness Munched Archive? 
> Whatever...

NUMA means non-uniform memory access. At least IBM, AMD and SGI do
NUMA; and I guess anyone with 100+ nodes *has* numa machine. (BUt as
andrea already explained, CONFIG_NUMA is already taken for generic
NUMA support.)

							Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
