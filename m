Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUDFQGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUDFQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:02:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42884
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263889AbUDFQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:01:43 -0400
Date: Tue, 6 Apr 2004 18:01:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040406160141.GX2234@dualathlon.random>
References: <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random> <20040406061646.B14800@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406061646.B14800@infradead.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:16:46AM +0100, Christoph Hellwig wrote:
> Can you try the patch below (testing it now, but I'm pretty sure it'll fix it)
> instead of all the kmalloc changes?:

I'm having some email dealy so I don't know if you sent me more recent
emails, did it work fine as expected or should I keep my kmalloc change?

thanks
