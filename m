Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbTH2XFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 19:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTH2XFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 19:05:25 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30476
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261682AbTH2XFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 19:05:20 -0400
Date: Fri, 29 Aug 2003 16:05:21 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030829230521.GD3846@matchmail.com>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829154101.GB16319@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829154101.GB16319@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 08:41:01AM -0700, Larry McVoy wrote:

> ====== sparc.bitmover.com ======
> Test separation: 8192 bytes: FAIL - cache not coherent

> VM page alias coherency test: minimum fast spacing: 16384 (2 pages)
> 0.29user 0.02system 0:00.31elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (107major+36minor)pagefaults 0swaps
> Linux sparc.bitmover.com 2.2.18 #2 Thu Dec 21 18:53:16 PST 2000 sparc64 unknown
> cpu		: TI UltraSparc IIi
> fpu		: UltraSparc IIi integrated FPU
> promlib		: Version 3 Revision 11
> prom		: 3.11.12
> type		: sun4u
> ncpus probed	: 1
> ncpus active	: 1
> BogoMips	: 539.03
> MMU Type	: Spitfire

Does this mean that userspace has to take into consideration that the isn't
coherent for adjacent small memory accesses on sparc?  What could happen if
it doesn't, or does it need to at all?
