Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUDEJ77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 05:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUDEJ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 05:59:59 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:17673 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261862AbUDEJ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 05:59:58 -0400
Date: Mon, 5 Apr 2004 10:59:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040405105912.A3896@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040403170258.GH2307@dualathlon.random>; from andrea@suse.de on Sat, Apr 03, 2004 at 07:02:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 07:02:58PM +0200, Andrea Arcangeli wrote:
> can you try this potential fix too? (maybe you want to try this first
> thing)
> 
> this is from Hugh's anobjramp patches.
> 
> I merged it once, then I got a crash report, so I backed it out since it
> was working anyways, but it was due a merging error that it didn't work
> correctly, the below version should be fine and it seems really needed.
> 
> I'll upload a new kernel with this applied.

Still fails with 2.6.5-aa3 which seems to have this one applied.
