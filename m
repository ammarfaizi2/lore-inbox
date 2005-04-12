Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVDLHRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVDLHRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVDLHOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:14:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25509 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261487AbVDLHLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:11:05 -0400
Date: Tue, 12 Apr 2005 09:07:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Claudio Martins <ctpm@rnl.ist.utl.pt>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Processes stuck on D state on Dual Opteron
Message-ID: <20050412070744.GB7161@suse.de>
References: <200504050316.20644.ctpm@rnl.ist.utl.pt> <200504111505.44284.ctpm@rnl.ist.utl.pt> <425B013A.5020108@yahoo.com.au> <200504120122.48168.ctpm@rnl.ist.utl.pt> <1113268760.5090.13.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113268760.5090.13.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12 2005, Nick Piggin wrote:
> Actually the patches I have sent you do fix real bugs, but they also
> make the block layer less likely to recurse into page reclaim, so it
> may be eg. hiding the problem that Neil's patch fixes.

Can you push those to Andrew? I'm quite happy with the way they turned
out. It would be nice if Ken would bench 2.6.12-rc2 with and without
those patches.

-- 
Jens Axboe

