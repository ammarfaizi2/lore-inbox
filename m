Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbUKCREY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUKCREY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKCREY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:04:24 -0500
Received: from cantor.suse.de ([195.135.220.2]:1225 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261732AbUKCREO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:04:14 -0500
Date: Wed, 3 Nov 2004 18:01:44 +0100
From: Andi Kleen <ak@suse.de>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove direct mem_map refs for x86-64
Message-ID: <20041103170144.GA1514@wotan.suse.de>
References: <200411031647.iA3GlmBm016951@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031647.iA3GlmBm016951@snoqualmie.dp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 08:47:48AM -0800, Matt Tolentino wrote:
> Hi Andi,
> 
> No real functional change here.  Just use the pfn_to_page
> macros instead of directly indexing into the mem_map. 
> Patch is against 2.6.10-rc1-mm2.  Please consider...

Thanks looks good. I put it into my tree.

-Andi
