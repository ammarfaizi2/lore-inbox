Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWBLVrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWBLVrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWBLVrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:47:03 -0500
Received: from cantor2.suse.de ([195.135.220.15]:7367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751460AbWBLVrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:47:01 -0500
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
Date: Sun, 12 Feb 2006 22:29:32 +0100
User-Agent: KMail/1.8.2
Cc: Ryan Richter <ryan@tau.solarneutrino.net>, Brian King <brking@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> <20060211223810.GA12064@tau.solarneutrino.net> <Pine.LNX.4.61.0602121838050.15101@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602121838050.15101@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602122229.33244.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 February 2006 19:57, Hugh Dickins wrote:

> So I'd like to believe that your x86_64-gart-dma-merge.patch is the
> final answer to this issue, and see it go forward into 2.6.16-rc -
> if you feel it's ready now.  Then we can just throw away those driver
> patches I posted a week ago (including the "ipr" one of this thread).

Yes, it's probably ready to go. I will submit it later if Andrew doesn't
beat me.

-Andi
