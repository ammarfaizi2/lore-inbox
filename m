Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTASEOr>; Sat, 18 Jan 2003 23:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTASEOr>; Sat, 18 Jan 2003 23:14:47 -0500
Received: from holomorphy.com ([66.224.33.161]:62085 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265385AbTASEOq>;
	Sat, 18 Jan 2003 23:14:46 -0500
Date: Sat, 18 Jan 2003 20:22:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>, akpm@zip.com.au, davej@codemonkey.org.uk,
       ak@muc.de, Erich Focht <efocht@ess.nec.de>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <20030119042245.GB770@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, akpm@zip.com.au,
	davej@codemonkey.org.uk, ak@muc.de, Erich Focht <efocht@ess.nec.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <200301171535.21226.efocht@ess.nec.de> <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain> <20030118070808.GA789@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030118070808.GA789@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 11:08:08PM -0800, William Lee Irwin III wrote:
> The severity of the MTRR regression in 2.5.59 is apparent from:

This is not a result of userland initscripts botching the MTRR; not
only are printk's in MTRR-setting routines not visible but it's also
apparent from the fact that highmem mem_map initialization suffers a
similar degradation adding almost a full 20 minutes to boot times.


-- wli
