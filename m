Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVJTTQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJTTQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJTTQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:16:12 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:43694 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932175AbVJTTQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:16:10 -0400
Date: Thu, 20 Oct 2005 21:16:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: William Weston <weston@lysdexia.org>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051020191620.GA21367@elte.hu>
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu> <20051018072844.GB21915@elte.hu> <1129669474.5929.8.camel@cmn3.stanford.edu> <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org> <20051019111943.GA31410@elte.hu> <1129835571.14374.11.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129835571.14374.11.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > indeed - and this could explain some of the lockups reported. I've 
> > uploaded -rt10 with your fix included.
> 
> No lockups so far with -rt12 (running for 1/2 a day already). 
> 
> I'm getting BUG messages again, some examples below...

would be interesting to check whether the cycle_t u64 fix in -rt14 gets 
rid of these BUG messages.

	Ingo
