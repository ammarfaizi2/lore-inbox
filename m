Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbSLUIrL>; Sat, 21 Dec 2002 03:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266837AbSLUIrL>; Sat, 21 Dec 2002 03:47:11 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:34057 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266810AbSLUIrK>; Sat, 21 Dec 2002 03:47:10 -0500
Date: Sat, 21 Dec 2002 08:55:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021221085510.A25881@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <20021221002940.GM25000@holomorphy.com> <190380000.1040432350@aslan.btc.adaptec.com> <20021221013500.GN25000@holomorphy.com> <223910000.1040435985@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <223910000.1040435985@aslan.btc.adaptec.com>; from gibbs@scsiguy.com on Fri, Dec 20, 2002 at 06:59:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 06:59:46PM -0700, Justin T. Gibbs wrote:
> Those were committed in separate changes into our local Perforce
> repository, but I simply don't have the patience to replicate each
> individual change in Perforce into a BK change.  Since all of the
> Linux universe likes stuff in BK format, I do what I can to accomodate
> them.

perforce can export unified diffs for each changeste-equivalent right?
for the sgi ptools SCCS we use internally I wrote a simple script
that extracts this diff, the commit message automates a BK checking
with this.  This makes my job of keeping mainline in sync a lot easier
and preserves the fine granuality.  And it works nicely although the
internal tree has some additional noise in it (kdb and HSM support).

> If it wasn't such a pain to get stuff into the tree, you would see
> smaller changesets.

Umm, getting smaller changesets in is not such a pain :)  Linus has
stated very often that he prefers small patches that do one thing and
I 100% agree with him.  Let me suggest we heel you out to get the
current update in (and I think with your latest slave_* fixes and/or
Doug's scsi_scan.c revamp it's time to get it in now) and you send
small, self-contained patches afterwards?

