Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVHPQVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVHPQVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVHPQVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:21:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61883 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1030218AbVHPQVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:21:16 -0400
Date: Tue, 16 Aug 2005 18:22:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt5
Message-ID: <20050816162200.GA3463@elte.hu>
References: <20050816121843.GA24308@elte.hu> <1124206316.5764.14.camel@localhost.localdomain> <1124207046.5764.17.camel@localhost.localdomain> <1124208507.5764.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124208507.5764.20.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, I compiled it now. Tried to boot, and it rebooted on me before
> showing any output :-(
> 
> So I'll start debugging it, but just incase I'm not looking for
> something that is already found, is there anything wrong with the
> following config?

your .config reboots here too. I suspect it's one of the latency tracing 
options that causes it. Perhaps some trace recursion?

	Ingo
