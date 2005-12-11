Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbVLKOYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVLKOYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVLKOYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 09:24:39 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:6798 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750704AbVLKOYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 09:24:39 -0500
Date: Sun, 11 Dec 2005 15:23:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: SLOB wishlist
Message-ID: <20051211142353.GA10131@elte.hu>
References: <20051211141716.GA8500@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211141716.GA8500@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., here's my SLOB wishlist:

 - would be nice to have DEBUG_SLOB - people want to debug their memory 
   allocations, no matter which allocator they use.

 - would be nice to have CONFIG_SLOB_INFO, to have /proc/slabinfo for 
   those who are ready to pay the .text price for it - this is nice for 
   memory leak debugging, etc. [should be /proc/slabinfo, not 
   /proc/slobinfo - to stay compatible with things like slabtop]

	Ingo
