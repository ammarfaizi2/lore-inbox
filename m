Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVCPIuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVCPIuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 03:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVCPIuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 03:50:55 -0500
Received: from mx1.elte.hu ([157.181.1.137]:55198 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261404AbVCPIuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 03:50:51 -0500
Date: Wed, 16 Mar 2005 09:50:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050316085029.GA11414@elte.hu>
References: <1110578809.19661.2.camel@mindpipe> <Pine.LNX.4.58.0503140214360.697@localhost.localdomain> <Pine.LNX.4.58.0503140427560.697@localhost.localdomain> <Pine.LNX.4.58.0503140509170.697@localhost.localdomain> <Pine.LNX.4.58.0503141024530.697@localhost.localdomain> <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu> <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu> <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Damn! The answer was right there in front of my eyes! Here's the
> cleanest solution. I forgot about wait_on_bit_lock.  I've converted
> all the locks to use this instead. [...]

ah, indeed, this looks really nifty. Andrew?

	Ingo
