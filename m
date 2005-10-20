Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVJTWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVJTWGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVJTWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:06:47 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25336 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750886AbVJTWGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:06:46 -0400
Message-ID: <435814F5.5080609@mvista.com>
Date: Thu, 20 Oct 2005 15:06:45 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain> <1129734626.19559.275.camel@tglx.tec.linutronix.de> <1129747172.27168.149.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
~> Could this cause a 2 second drop backwards?
> 
> 
A 2 second warp is _most_ likely an overflow issue with nanoseconds (not many seconds fit in a 
32-bit long).

~


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
