Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWHKEYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWHKEYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWHKEYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:24:50 -0400
Received: from mx1.suse.de ([195.135.220.2]:35049 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751436AbWHKEYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:24:49 -0400
From: Neil Brown <neilb@suse.de>
To: Willy Tarreau <w@1wt.eu>
Date: Fri, 11 Aug 2006 14:24:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17628.1673.458051.204628@cse.unsw.edu.au>
Cc: Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
In-Reply-To: message from Willy Tarreau on Friday August 11
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
	<20060810045711.GI8776@1wt.eu>
	<17627.53340.43470.60811@cse.unsw.edu.au>
	<20060811035756.GB1261@1wt.eu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 11, w@1wt.eu wrote:
> On Fri, Aug 11, 2006 at 10:33:32AM +1000, Neil Brown wrote:

> > We've had reports of OOM problems with NFS at SuSE.
> > The common factors seem to be lots of memory (6G+) and very large
> > files. 
> 
> Just out of curiosity, does it happen on 32bit or 64bit machines (or both) ?

Both.
If it was just 32bit I'd be blaming highmem in a flash. 
But it's not that easy :-(

NeilBrown
