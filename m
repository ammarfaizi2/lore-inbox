Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUG0IQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUG0IQo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUG0IQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:16:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7315 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266344AbUG0IQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:16:42 -0400
Date: Tue, 27 Jul 2004 10:17:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J4
Message-ID: <20040727081721.GA7486@elte.hu>
References: <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040727053338.GE1433@suse.de> <20040727080127.GA6988@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727080127.GA6988@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> [i've sent a second patch too since the first version.]

and here's a third one:

  http://redhat.com/~mingo/voluntary-preempt/tune-max-sectors-2.6.8-rc2-A0

this includes the dm-table.c fix and also fixes other stacked drivers 
and updates blk_queue_stack_limits() to change max_hw_sectors too.

this patch should be pretty complete i believe.

	Ingo
