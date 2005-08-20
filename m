Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVHTHVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVHTHVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 03:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHTHVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 03:21:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34811 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932582AbVHTHVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 03:21:07 -0400
Message-ID: <43067713.4040700@mvista.com>
Date: Fri, 19 Aug 2005 17:19:31 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
References: <20050818060126.GA13152@elte.hu> <1124495303.23647.579.camel@tglx.tec.linutronix.de>
In-Reply-To: <1124495303.23647.579.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
~
> 
> 2. Drift of cyclic timers (armed by set_timer()):
> 
> Due to rounding errors and the drift adjustment code, the fixed
> increment which is precalculated when the timer is set up and added on
> rearm, I see creeping deviation from the timeline. 
> 
> I have a patch lined up to base the rearm on human (nsac) units, so this
> effect will go away. But this is waste of time until (1.) is not solved.
> 
> George ???

Could I (we) see what you have in mind?

> 
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
