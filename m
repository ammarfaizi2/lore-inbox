Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTE1HUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 03:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264589AbTE1HUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 03:20:37 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:2567 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264582AbTE1HUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 03:20:36 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jens Axboe <axboe@suse.de>, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Wed, 28 May 2003 09:32:29 +0200
User-Agent: KMail/1.5.2
Cc: manish <manish@storadinc.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de>
In-Reply-To: <20030528071355.GO845@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305280930.48810.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 May 2003 09:13, Jens Axboe wrote:

Hi Jens,

> If you leave nr_requests as it is, I don't see why it should not boot
> with batch_requests == 0.
> I can't see in all of these mails whether backing out akpm's starvation
> patch makes the problem go away. Does it?
If you mean 
"http://linux.bkbits.net:8080/linux-2.4/diffs/drivers/block/ll_rw_blk.c@1.29?nav=index.html|ChangeSet@-2y|cset@1.160|hist/drivers/block/ll_rw_blk.c"

that one, the answer is YES.

ciao, Marc


