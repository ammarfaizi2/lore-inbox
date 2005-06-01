Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVFAICg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVFAICg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVFAICg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:02:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21441 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261326AbVFAICb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:02:31 -0400
Date: Wed, 1 Jun 2005 10:01:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-10
Message-ID: <20050601080138.GD25081@elte.hu>
References: <20050527072810.GA7899@elte.hu> <429C1206.5000707@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C1206.5000707@mrv.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eran Mann <emann@mrv.com> wrote:

> I tried to compile -V0.7.47-15 and it fails to compile.
> net/sunrpc/sched.c: In function `rpc_run_timer':
> net/sunrpc/sched.c:107: error: `RPC_TASK_HAS_TIMER' undeclared (first 
> use in this function)
> ...
> 
> It seems the following hunk of the patch is bogus as it removes a 
> required define:

indeed - fixed it in -47-16.

	Ingo
