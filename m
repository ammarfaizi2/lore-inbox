Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVHVWLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVHVWLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVHVWLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:50 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751258AbVHVWLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:46 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: danial_thom@yahoo.com, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Date: Mon, 22 Aug 2005 14:46:09 +0300
User-Agent: KMail/1.5.4
References: <20050821202141.78795.qmail@web33305.mail.mud.yahoo.com>
In-Reply-To: <20050821202141.78795.qmail@web33305.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221446.09100.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 August 2005 23:21, Danial Thom wrote:
> > You problem could very well be something else
> > entirely, but try a
> > kernel build with PREEMPT_NONE and HZ=100 and
> > see if it makes a big
> > difference (or if that's your current config,
> > then try the opposite,
> > HZ=1000 and PREEMPT). If it does make a
> > difference, then that's a
> > valuable piece of information to report on the
> > list. If it turns out
> > it makes next to no difference at all, then
> > that as well is relevant
> > information as then people will know that HZ &
> > preempt is not the
> > cause and can focus on finding the problem
> > elsewhere.
>
> Yes. Hz isn't going to make much difference on a
> 2.0Ghz opteron, but I can see how premption can
> cause packet loss. Shouldn't packet processing be
> the highest priority process? It seems pointless
> to "keep the audio buffers full" if you're
> dropping packets as a result. 
> 
> Also some clown typing on the keyboard shouldn't
> cause packet loss. Trading network integrity for
> snappy responsiveness is a bad trade.

You do not need to argue about usefulness of preempt
(or lack thereof). You need to try non-PREEMPT kernel
as suggested (if you really are interested in fixing
performance degradation you observe, that is).

http://www.catb.org/~esr/faqs/smart-questions.html
--
vda

