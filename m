Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261952AbTDAAgC>; Mon, 31 Mar 2003 19:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261958AbTDAAgC>; Mon, 31 Mar 2003 19:36:02 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14467
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S261952AbTDAAgB>;
	Mon, 31 Mar 2003 19:36:01 -0500
Date: Tue, 1 Apr 2003 02:47:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
Message-ID: <20030401004722.GC12718@x30.random>
References: <20030328040038.GO1350@holomorphy.com> <20030330231945.GH2318@x30.local> <20030331042729.GQ30140@holomorphy.com> <20030331183506.GC11026@x30.random> <20030331194117.A27859@infradead.org> <20030331190803.GS30140@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331190803.GS30140@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:08:03AM -0800, William Lee Irwin III wrote:
> I think the rmap allocations currently depend on CONFIG_MMU; IMHO it
> can be moved to CONFIG_SWAP if/when objrmap is merged since only

moving rmap under CONFIG_SWAP makes perfect sense to me. That could
payoff big on the big irons too, not just for embedded. Making it a
runtime option would be the best.

Andrea
