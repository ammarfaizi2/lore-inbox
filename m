Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVE0NfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVE0NfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 09:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVE0NfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 09:35:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:2733 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262477AbVE0Neo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 09:34:44 -0400
Date: Fri, 27 May 2005 15:34:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, nickpiggin@yahoo.com.au, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527133404.GA15496@elte.hu>
References: <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <20050526200424.GA27162@elte.hu> <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu> <20050527125630.GE86087@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527125630.GE86087@muc.de>
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


* Andi Kleen <ak@muc.de> wrote:

> But at least CONFIG_PREEMPT is still reasonably cheap, so it is not as 
> intrusive as some of the stuff proposed.

actually, PREEMPT_RT is not nearly as intrusive (on the source level) as 
PREEMPT. It's not even in the same ballpark. (because it mostly rides on 
the top of the intrusion caused by SMP and PREEMPT support.)

it's intrusive in terms of performance impact.

	Ingo
