Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUCLNkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUCLNkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:40:36 -0500
Received: from holomorphy.com ([207.189.100.168]:35589 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262104AbUCLNkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:40:35 -0500
Date: Fri, 12 Mar 2004 05:40:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312134024.GS655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com> <20040312122127.GQ30940@dualathlon.random> <20040312124638.GR655@holomorphy.com> <20040312132436.GT30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312132436.GT30940@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 02:24:36PM +0100, Andrea Arcangeli wrote:
> did you try specweb with apache? that's super heavy mremap as far as I
> know (and it maybe using anon memory, and if not I certainly cannot
> exclude other apps are using mremap on significant amounts of anymous
> ram). To a point that the kmap_lock for the persistent kmaps I used
> originally in mremap (at least it has never been racy) was a showstopper
> bottleneck spending most of system time there (profiling was horrible in
> the kmap_lock) and I had to fixup the 2.6 way with the per-cpu atomic
> kmaps to avoid being an order of magnitude slower than in the small
> boxes w/o highmem.

No. I have never had access to systems set up for specweb.


-- wli
