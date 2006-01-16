Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWAPLsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWAPLsL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWAPLsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:48:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52709 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751015AbWAPLsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:48:10 -0500
Date: Mon, 16 Jan 2006 11:48:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-xfs@oss.sgi.com, Jeff Mahoney <jeffm@suse.com>,
       Mattia Dongili <malattia@linux.it>
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
Message-ID: <20060116114805.GB12069@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Nathan Scott <nathans@sgi.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com,
	Jeff Mahoney <jeffm@suse.com>, Mattia Dongili <malattia@linux.it>
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060115221458.GA3521@inferi.kami.home> <20060116094817.A8425113@wobbly.melbourne.sgi.com> <43CB6796.4040104@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CB6796.4040104@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:29:58AM -0800, Hans Reiser wrote:
> Thanks Nathan, Mattia, and Andrew.
> 
> vs, can you or Jeff look at whether our buffer head inits are
> sufficiently hardened by next Monday (I know that vs has a lot of mail
> to catch up to)?  Jeff, if you have time before then, it would be nice
> if you could handle it, I know hardening V3 is an interest of yours.

Chris Mason just sent a patch to -fsdevel that initialized bh->b_private
in reiserfs.  Mattia, I'll bounce you the patch privately, could you try
to see if it helps?

