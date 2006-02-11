Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWBKWib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWBKWib (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBKWib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:38:31 -0500
Received: from solarneutrino.net ([66.199.224.43]:36616 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750770AbWBKWia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:38:30 -0500
Date: Sat, 11 Feb 2006 17:38:10 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Brian King <brking@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
Message-ID: <20060211223810.GA12064@tau.solarneutrino.net>
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

This patch survived 6 runs, and I'll keep running it.

-ryan
