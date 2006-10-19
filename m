Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945924AbWJSAbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWJSAbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 20:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945927AbWJSAbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 20:31:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:29409 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1945924AbWJSAbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 20:31:48 -0400
From: Neil Brown <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Thu, 19 Oct 2006 10:31:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17718.51050.186385.512984@cse.unsw.edu.au>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] nfs endianness annotations
In-Reply-To: message from Trond Myklebust on Wednesday October 18
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
	<1161206763.6095.172.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 18, trond.myklebust@fys.uio.no wrote:
> On Tue, 2006-10-10 at 04:09 +0100, Al Viro wrote:
> > Series below does endianness annotations of nfs and nfsd; it had been
> > sitting in my tree for quite a while.  In part it's based on Alexey's
> > patches.
> > 
> > I thought to hold it back until the next merge window, but since we
> > do get new breakage that would be instantly caught by endianness checks...
> > IMO it makes sense to see if that puppy could be merged at this point.
> > In any case, the first patch in series is absolutely needed - it's
> > fixing a genuine recently introduced bug.
> 
> Hi Al,
> 
> ACK on patches # 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12. I'd be quite happy
> to get those into mainline ASAP.
> 
> I'll defer to Neil for the rest.

Thanks for the reminder Trond.

Yes, 

Acked-By: NeilBrown <neilb@suse.de>

for 1, 13-25.
Thanks for doing this - there are some important cleanups in there,
particular the clear differentiation between err and host_err (not to
mention the bug fixes!).

Thanks,
NeilBrown
