Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbWBGDrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWBGDrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWBGDrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:47:13 -0500
Received: from solarneutrino.net ([66.199.224.43]:58119 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S964960AbWBGDrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:47:12 -0500
Date: Mon, 6 Feb 2006 22:09:02 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Brian King <brking@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
Message-ID: <20060207030902.GA4991@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> <43E7613B.5060706@us.ibm.com> <Pine.LNX.4.61.0602061621450.3560@goblin.wat.veritas.com> <200602062211.29993.ak@suse.de> <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602062154430.3652@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 10:11:09PM +0000, Hugh Dickins wrote:
> Below is, I think, the 2.6.15 equivalent of the patch Andi posted.
> Ryan cannot effectively test Andi's patch on 2.6.16-rc because Mike
> Christie's scsi_execute_async changes have serendipitously fixed
> the st instance.  Ryan, would you be able to test the patch below
> on 2.6.15 without my st.c,st.h patch?

Sure, I'll try this out.  It'll probably have to wait for the weekend
again.

-ryan
