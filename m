Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbVCANYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbVCANYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVCANYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:24:21 -0500
Received: from cantor.suse.de ([195.135.220.2]:5861 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261906AbVCANXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:23:24 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050227212536.GG3120@waste.org>
References: <2.416337461@selenic.com> <200502271417.51654.agruen@suse.de>
	 <20050227212536.GG3120@waste.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1109683402.22077.47.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Mar 2005 14:23:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-27 at 22:25, Matt Mackall wrote:
> On Sun, Feb 27, 2005 at 02:17:51PM +0100, Andreas Gruenbacher wrote:
> > Matt,
> > 
> > On Monday 31 January 2005 08:34, Matt Mackall wrote:
> > > This patch adds a generic array sorting library routine. This is meant
> > > to replace qsort, which has two problem areas for kernel use.
> > 
> > the sort function is broken. When sorting the integer array {1, 2, 3, 4, 5}, 
> > I'm getting {2, 3, 4, 5, 1} as a result. Can you please have a look?
> 
> Which kernel? There was an off-by-one for odd array sizes in the
> original posted version that was quickly spotted:
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/broken-out/sort-fix.patch

Just for the record: This fixed it.

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

