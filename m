Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVKJMPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVKJMPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVKJMPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:15:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34531 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750805AbVKJMPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:15:54 -0500
Date: Thu, 10 Nov 2005 13:15:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1 (now rt6)
Message-ID: <20051110121545.GA14133@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <20051030133316.GA11225@elte.hu> <1131158124.4834.24.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131158124.4834.24.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Doing a loop with "sleep 10" bbracketed by calls to date gives me
> sporadic results:
> 
> --- Fri Nov  4 18:30:25 PST 2005
> 10
> ---
> --- Fri Nov  4 19:43:53 PST 2005
> 10
> ---
> --- Fri Nov  4 19:44:03 PST 2005
> 3
> ---
> --- Fri Nov  4 18:30:48 PST 2005
> 10
> ---
> --- Fri Nov  4 18:30:58 PST 2005
> 0
> ---

i'm running your timer-test script with an earlier config you sent 
(kernel-2.6.13-i686-smp.ccrma.config), on a similar SMP box, and i'm not 
getting these timeout problems (using -rt9). How easily do the above 
problems reproduce - does it happen right after bootup?

(to make sure could you send me your current SMP .config too? You have 
CONFIG_KTIME_SCALAR disabled, right?)

	Ingo
