Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUDBHLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDBHLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:11:16 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:58894 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263246AbUDBHLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:11:15 -0500
Date: Fri, 2 Apr 2004 08:11:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040402081109.A32036@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mackerras <paulus@samba.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
	hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040402001535.GG18585@dualathlon.random> <Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain> <20040402011627.GK18585@dualathlon.random> <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040401180802.219ece99.akpm@osdl.org> <20040402022233.GQ18585@dualathlon.random> <20040402070525.A31581@infradead.org> <16493.4424.598870.574364@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16493.4424.598870.574364@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Apr 02, 2004 at 05:07:52PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 05:07:52PM +1000, Paul Mackerras wrote:
> The HPC types also love hugetlbfs since it reduces their tlb miss
> rate.

Thanks, forgot that one.  Still it's a tiny subset of the linux userbase.

