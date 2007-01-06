Return-Path: <linux-kernel-owner+w=401wt.eu-S1751174AbXAFKCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbXAFKCd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 05:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbXAFKCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 05:02:33 -0500
Received: from brick.kernel.dk ([62.242.22.158]:24428 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbXAFKCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 05:02:32 -0500
Date: Sat, 6 Jan 2007 11:02:55 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Torsten Kaiser <kernel@bardioc.dyndns.org>
Cc: Andrew Morton <akpm@osdl.org>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.20-rc3-mm1] raid1 mount blocks for ever
Message-ID: <20070106100255.GH11203@kernel.dk>
References: <368051775.16914@ustc.edu.cn> <20070105195911.37c40e94.akpm@osdl.org> <200701061052.00455.kernel@bardioc.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701061052.00455.kernel@bardioc.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06 2007, Torsten Kaiser wrote:
> On Saturday 06 January 2007 04:59, Andrew Morton wrote:
> >
> > http://userweb.kernel.org/~akpm/2.6.20-rc3-mm1x.bz2 is basically
> > 2.6.20-rc3-mm1, minus git-block.patch.  Can you and Torsten please test
> > that, see if the hangs go away?
> 
> Works for me too.

Torsten, can you test XFS with barriers disabled? I have a feeling that
is where the problem lies.

-- 
Jens Axboe

