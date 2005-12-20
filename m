Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVLTPFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVLTPFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbVLTPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:05:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:14809 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750986AbVLTPFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:05:00 -0500
Date: Tue, 20 Dec 2005 16:04:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
Message-ID: <20051220150421.GA4164@elte.hu>
References: <43A5A7B5.21A4CAAE@tv-sign.ru> <20051220143848.GA2053@elte.hu> <43A82C78.2A1E9481@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A82C78.2A1E9481@tv-sign.ru>
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


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > (the resulting kernel doesnt build in PREEMPT_RT mode though, it's
> > lib/plist.c not being converted yet?)
> 
> Ingo, sorry, I sent you a wrong plist.c !!! plist.c should also do 
> this rename, but I sent you an old file.
> 
> This is updated patch:

thanks, this one builds fine and boots fine on a dual-core X2 box, in 
full PREEMPT_RT mode. I cannot see anything obviously wrong going on, so 
i've released this as -rt4.

could you send the doc fixups against -rt4? Please also add back the 
credits to plist.h (and add your own name for these improvements).  
Thanks,

	Ingo
