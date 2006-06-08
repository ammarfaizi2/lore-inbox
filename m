Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWFHItF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWFHItF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWFHItF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:49:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:39367 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964799AbWFHItE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:49:04 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.17-rc6-rt1
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20060607211455.GA6132@elte.hu>
References: <20060607211455.GA6132@elte.hu>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 10:51:49 +0200
Message-Id: <1149756709.11429.5.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change was the port to 2.6.17-rc6, and the moving to John's 
> latest and greatest GTOD queue.

hangcheck-timer.c misses monotonic_clock().

