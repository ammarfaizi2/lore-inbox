Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUDEEmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 00:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUDEEmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 00:42:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:33668
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263091AbUDEEmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 00:42:47 -0400
Date: Mon, 5 Apr 2004 06:42:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
Cc: akpm@osdl.org, hugh@veritas.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040405044250.GB2234@dualathlon.random>
References: <Pine.LNX.4.44.0403150527400.28579-100000@localhost.localdomain> <Pine.GSO.4.58.0403211634350.10248@azure.engin.umich.edu> <20040325225919.GL20019@dualathlon.random> <Pine.GSO.4.58.0403252258170.4298@azure.engin.umich.edu> <Pine.LNX.4.58.0404042311380.19523@red.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404042311380.19523@red.engin.umich.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 11:14:25PM -0400, Rajesh Venkatasubramanian wrote:
> 
> This patch fixes a couple of mask overflow bugs in the prio_tree
> search code. These bugs trigger in some very rare corner cases.
> The patch also removes a couple of BUG_ONs from the fast paths.
> 
> Now the code is well-tested. I have tested all __vma_prio_tree_*
> functions in the user-space with as many as 10 million vmas and
> all prio_tree functions work fine.

This is a great news.

> 
> This patch is against 2.6.5-aa2. It will apply on top of Hugh's
> patches also.

I'm releasing an update for this.

> If you like to test the prio_tree code further in the user-space,
> the programs in the following link may help you.
> 
> http://www-personal.engin.umich.edu/~vrajesh/linux/prio_tree/user_space/

thanks for this great work.
