Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWDQAIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDQAIa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWDQAIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 20:08:30 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:26852 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750857AbWDQAI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 20:08:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [ck] Re: [patch][rfc] quell interactive feeding frenzy
Date: Mon, 17 Apr 2006 10:08:08 +1000
User-Agent: KMail/1.9.1
Cc: Al Boldi <a1426z@gawab.com>, ck list <ck@vds.kolivas.org>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
References: <200604112100.28725.kernel@kolivas.org> <200604160923.00047.kernel@kolivas.org> <20060416184426.GA15642@rhlx01.fht-esslingen.de>
In-Reply-To: <20060416184426.GA15642@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604171008.10067.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 April 2006 04:44, Andreas Mohr wrote:
> Hi,
>
> On Sun, Apr 16, 2006 at 09:22:59AM +1000, Con Kolivas wrote:
> > The current value, 6ms at 1000HZ, is chosen because it's the largest
> > value that can schedule a task in less than normal human perceptible
> > range when two competing heavily cpu bound tasks are the same priority.
> > At 250HZ it works out to 7.5ms and 10ms at 100HZ. Ironically in my
> > experimenting I found the cpu cache improvements become much less
> > significant above 7ms so I'm very happy with this compromise.
>
> Heh, this part is *EXACTLY* a fully sufficient explanation of what I was
> wondering about myself just these days ;)
> (I'm experimenting with different timeslice values on my P3/450 to verify
> what performance impact exactly it has)
> However with a measly 256kB cache it probably doesn't matter too much,
> I think.
>
> But I think it's still important to mention that your perception might be
> twisted by your P4 limitation (no testing with slower and really slow
> machines).

You underestimate me. Those cpu cache effects were performance effects 
measured down to a PII 233, but all were i386 architecture. As for 
"perception" this isn't my testing I'm talking about; these are 
neuropsychiatric tests that have nothing to do with pcs or what processor you 
use ;)

-- 
-ck
