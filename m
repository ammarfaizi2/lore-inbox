Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267232AbTAPTlx>; Thu, 16 Jan 2003 14:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267235AbTAPTlx>; Thu, 16 Jan 2003 14:41:53 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:45001 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267232AbTAPTlw>; Thu, 16 Jan 2003 14:41:52 -0500
Date: Thu, 16 Jan 2003 11:43:10 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>
cc: Robert Love <rml@tech9.net>, Erich Focht <efocht@ess.nec.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH 2.5.58] new NUMA scheduler: fix
Message-ID: <115000000.1042746190@flay>
In-Reply-To: <Pine.LNX.4.44.0301162025300.9563-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301162025300.9563-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> complex. It's the one that is aware of the global scheduling picture. For
> NUMA i'd suggest two asynchronous frequencies: one intra-node frequency,
> and an inter-node frequency - configured by the architecture and roughly
> in the same proportion to each other as cachemiss latencies.

That's exactly what's in the latest set of patches - admittedly it's a
multiplier of when we run load_balance, not the tick multiplier, but 
that's very easy to fix. Can you check out the stuff I posted last night?
I think it's somewhat cleaner ...

M.

