Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVCOR6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVCOR6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCORt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:49:56 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:24594
	"EHLO cynthia.pants.nu") by vger.kernel.org with ESMTP
	id S261688AbVCORte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:49:34 -0500
Date: Tue, 15 Mar 2005 09:49:30 -0800
From: Brad Boyer <flar@allandria.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 iSeries: cleanup viopath
Message-ID: <20050315174929.GC10301@pants.nu>
References: <20050315143412.0c60690a.sfr@canb.auug.org.au> <0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org> <20050316025339.318fc246.sfr@canb.auug.org.au> <20050315174310.GH498@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315174310.GH498@austin.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 11:43:10AM -0600, Linas Vepstas wrote:
> FWIW, keep in mind that a cache miss due to large structures not fitting
> is a zillion times more expensive than byte-aligning in the cpu 
> (even if byte operands had a cpu perf overhead, which I don't think 
> they do on ppc).

Actually, there is a small overhead to bytes if you make them signed.
That's why char is unsigned by default on ppc.

	Brad Boyer
	flar@allandria.com

