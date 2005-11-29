Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVK2H3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVK2H3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVK2H3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:29:03 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:47780 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751345AbVK2H3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:29:01 -0500
Date: Tue, 29 Nov 2005 08:29:22 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051129072922.GA21696@elte.hu>
References: <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe> <1133034406.32542.308.camel@tglx.tec.linutronix.de> <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe> <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe> <20051128160052.GA29540@elte.hu> <1133217651.4678.2.camel@mindpipe> <1133230103.5640.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133230103.5640.0.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2005-11-28 at 17:40 -0500, Lee Revell wrote:
> > 2.6.11-RT-V0.7.40-04 works
> 
> and 2.6.12-RT-V0.7.51-28 does not.

thanks. I have further narrowed it down from this point: your .config 
breaks from the 51-01 to the 51-02 kernel (on my testbox).

	Ingo
