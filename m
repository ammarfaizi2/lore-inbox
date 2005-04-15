Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVDOICF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVDOICF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVDOICF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:02:05 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17293 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261764AbVDOIB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:01:58 -0400
Date: Fri, 15 Apr 2005 10:01:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
Message-ID: <20050415080138.GA25262@elte.hu>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org> <20050412230921.GA22360@elte.hu> <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> On Wed, 13 Apr 2005, Ingo Molnar wrote:
> 
> > what are you using kprobes for? Do you get lockups even if you disable 
> > kprobes?
> 
> Various processes will lockup on the P4/HT system, usually while under 
> some load.  The processes cannot be killed.  X will lockup once or 
> twice a day (which means my console, and thus sysrq, are toast), but I 
> can still ssh in.  Nothing is logged by the kernel.  Are there any 
> post-lockup forensics that can be performed before I reboot?

could you try the -44-03 patch:

 http://redhat.com/~mingo/realtime-preempt/older/realtime-preempt-2.6.12-rc2-V0.7.44-03

this doesnt have the plist changes yet. Is this one more stable?

	Ingo
