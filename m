Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVLERn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVLERn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVLERn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:43:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8328 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932485AbVLERnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:43:25 -0500
Date: Mon, 5 Dec 2005 18:43:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: dino@in.ibm.com, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rt21 & evolution
Message-ID: <20051205174321.GA6191@elte.hu>
References: <1133642866.16477.11.camel@cmn3.stanford.edu> <1133647737.5890.2.camel@mindpipe> <1133653696.16477.47.camel@cmn3.stanford.edu> <20051204145823.GA5756@in.ibm.com> <1133804294.4752.1.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133804294.4752.1.camel@cmn3.stanford.edu>
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


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > Can you try this patch below. Ingo has already included it in his tree
> > and will probably show up in -rt22.
> > 
> > This was changed in -rt14 and returns spurious -ETIMEDOUT from
> > FUTEX_WAIT calls which I just checked that evo does a lot of
> 
> Good news. I tried it and seems to be working. Not conclusive as this 
> was just one evolution startup in the morning but there were no 
> crashes (and I was consistently getting them with plain -rt21).

thanks for the testing - i've released -rt22 with this fix included.

	Ingo
