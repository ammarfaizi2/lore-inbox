Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUH1Pt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUH1Pt5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbUH1Pt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:49:57 -0400
Received: from waste.org ([209.173.204.2]:20146 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267285AbUH1Ptz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:49:55 -0400
Date: Sat, 28 Aug 2004 10:48:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, paulus@samba.org, ak@muc.de,
       davem@davemloft.net, ak@suse.de, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040828154842.GM5414@waste.org>
References: <Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com> <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org> <16687.59671.869708.795999@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com> <20040827204241.25da512b.akpm@osdl.org> <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com> <20040827223954.7d021aac.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827223954.7d021aac.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:39:54PM -0700, Andrew Morton wrote:

> As I said - for both these applications we need a new type which is
> atomic64_t on 64-bit and atomic_t on 32-bit.

atomic_long_t -> longest available atomic type?

-- 
Mathematics is the supreme nostalgia of our time.
