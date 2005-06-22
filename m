Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVFVJ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVFVJ0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVFVJWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:22:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45780 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262828AbVFVHp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:45:28 -0400
Date: Wed, 22 Jun 2005 09:40:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
       William Weston <weston@sysex.net>, "K.R. Foley" <kr@cybsft.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>, linux-ns83820@kvack.org,
       nhorman@redhat.com, Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050622074054.GC16508@elte.hu>
References: <20050608112801.GA31084@elte.hu> <20050621131009.GA22691@elte.hu> <20050621201742.GA16400@kvack.org> <200506212242.39113.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506212242.39113.gene.heskett@verizon.net>
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


* Gene Heskett <gene.heskett@verizon.net> wrote:

> FWIW, 50-06 is running clean here with mode 3 & no hardirq threading.  
> Uptime is about 9 hours.
> 
> Would it do any good to try mode 4 & see if tvtime still runs?  
> Previously, I got the impression that was a dma problem & posted some 
> of the logs, but I've not noted any fixes for that go by.

sure, any extra testing - even if it finds no problems, is just as 
useful. Especially if you have a .config where everything works. That 
way we'll know for sure that any regressions are related to PREEMPT_RT.

	Ingo
