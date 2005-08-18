Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVHRJxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVHRJxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVHRJxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:53:40 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:25559 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932136AbVHRJxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:53:39 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.13-rc6-rt3
Date: Thu, 18 Aug 2005 10:57:30 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20050816121843.GA24308@elte.hu>
In-Reply-To: <20050816121843.GA24308@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508181057.30828.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 13:18, Ingo Molnar wrote:
> i have released the 2.6.13-rc6-rt3 tree, which can be downloaded from
> the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> Changes since 2.6.13-rc6-rt2:

Ingo,

I haven't used any of the RT patches since V0.7.51-xx, but I upgraded to -rt8 
yesterday and had a couple of problems. I've just noticed you released -rt9, 
but I don't think my problem is listed as fixed.. I'll upgrade anyway, in a 
minute.

The problem I'm having is that when the kernel probes my IDE devices it slows 
down, taking ages to complete the probe. Henceforth the kernel seems to work 
at a slower speed doing just about anything (compiling, etc.), but 
interactive performance is okay. It's a bizarre problem.

Of course, I assumed this was due to the latest timer changes, and so I 
disabled CONFIG_HIGH_RES_TIMERS and went back to CONFIG_HPET_TIMER.
This works perfectly.

For the moment, is it worth debugging problems in the high res timers set or 
are there known (fixable) issues?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
