Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWEIO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWEIO6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWEIO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:58:04 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:60063 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751472AbWEIO6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:58:02 -0400
Message-ID: <4460ADF8.4040301@compro.net>
Date: Tue, 09 May 2006 10:58:00 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
In-Reply-To: <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Tue, 2006-05-09 at 08:23 -0400, Mark Hounschell wrote:
>> Can I assume configuring 'Complete preemption' is the same as
>> configuring ('Voluntary preemption' + 'Hardirq' + 'Softirq' + default
>> proc settings)?
> 
> Not Voluntary preemption, and I'm not sure what default proc settings is
> referring too .

The proc settings or boot options to enable or disable hardirq or
softirq threading that you have avaialable in Voluntary preemption.

> Complete preemption is like CONFIG_PREEMPT and softirq
> and hardirq threading .. The preemption isn't voluntary, it's forced .
> 

Complete preemption you have no choice of threading hard or soft irqs.
They are threaded.

So If I config Voluntary preemption + Hardirq and Softirq threading and
do not disable hardirq or softirq via proc or boot cmdline, is that the
same as configuring Complete preemption?

Mark

