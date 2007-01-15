Return-Path: <linux-kernel-owner+w=401wt.eu-S932092AbXAOICY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbXAOICY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 03:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbXAOICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 03:02:24 -0500
Received: from www.osadl.org ([213.239.205.134]:42403 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932092AbXAOICX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 03:02:23 -0500
Subject: Re: 2.6.20-rc4-mm1 md problem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <20070115071747.GA31267@elte.hu>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
	 <20070115071747.GA31267@elte.hu>
Content-Type: text/plain
Date: Mon, 15 Jan 2007 09:08:33 +0100
Message-Id: <1168848513.2941.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 08:17 +0100, Ingo Molnar wrote:
> > Debug plan:
> > - revert md-* patches
> > - binary search
> > 
> > Does someone have a better idea?
> 
> Thomas saw something similar yesterday and he the partial results that 
> git.block (between rc2-mm1 and rc4-mm1) breaks certain disk drivers or 
> filesystems drivers. For me it worked fine, so it must be only on some 
> combinations. The changes to ll_rw_block.c look quite extensive.

Yes. Jens Axboe confirmed yesterday that the plug changes broke RAID.

	tglx
 

