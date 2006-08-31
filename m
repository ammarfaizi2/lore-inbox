Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWHaReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWHaReG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWHaReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:34:06 -0400
Received: from pat.uio.no ([129.240.10.4]:18565 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932279AbWHaReD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:34:03 -0400
Subject: Re: bug in nfs in 2.6.18-rc5?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@infradead.org>
Cc: Shaya Potter <spotter@cs.columbia.edu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, unionfs@fsl.cs.sunysb.edu
In-Reply-To: <20060831162628.GA23925@infradead.org>
References: <44F6F80F.1000202@cs.columbia.edu>
	 <1157040230.11347.31.camel@localhost>
	 <20060831162628.GA23925@infradead.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 13:33:46 -0400
Message-Id: <1157045626.11347.97.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.197, required 12,
	autolearn=disabled, AWL 1.80, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 17:26 +0100, Christoph Hellwig wrote:
> On Thu, Aug 31, 2006 at 12:03:50PM -0400, Trond Myklebust wrote:
> > If we're to provide the ability for unionfs to use lookup_one_len() on
> > NFS, then we will have to error out whenever we hit a case where we
> > should be creating a new mountpoint. Is that acceptable?
> 
> Not at all.  unionfs will have to pass down proper lookup intents.
> The ecryptfs developers have started looking into making that work
> with stackable filesystems, and the unionfs developers should follow
> that effort.

Good. I fully agree that this is preferable.

Cheers,
  Trond

