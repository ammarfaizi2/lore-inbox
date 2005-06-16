Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVFPUte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVFPUte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVFPUte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:49:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9857 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261811AbVFPUtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:49:31 -0400
Date: Thu, 16 Jun 2005 22:43:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050616204358.GA4656@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com> <20050616072935.GB19772@elte.hu> <42B160F5.9060208@cybsft.com> <20050616173247.GA32552@elte.hu> <42B1BDF7.1000700@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1BDF7.1000700@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> >>[...] That works to get the system booted. Although I am getting many 
> >>soft lockups now, minutes after the boot. Log attached. [...]
> >
> >
> >hm, do you get actual lockups, or only the messages about them? I.e.  
> >does the system work fine if you [the sounds of careful thinking to get 
> >the word right] disable CONFIG_DETECT_SOFTLOCKUP, or does it lock up 
> >silently?
> 
> There doesn't seem to be any actual lockups, just messages. I will try 
> disabling the above when I get home this evening. Can't get to the 
> system right now.

i tweaked the softlockup detector in the last patch a bit (to fix false 
positives under very high loads), might have broken it on SMP.

	Ingo
