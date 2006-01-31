Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWAaObW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWAaObW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 09:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWAaObW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 09:31:22 -0500
Received: from dns.toxicfilms.tv ([150.254.220.184]:26504 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1750859AbWAaObV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 09:31:21 -0500
X-Spam-Report: SA TESTS
 -1.7 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -2.3 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(85.221.144.160):SA:0(-4.0/2.5):. Processed in 1.373993 secs Process 7804)
Date: Tue, 31 Jan 2006 15:31:23 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <19210076647.20060131153123@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Linux 2.6.15.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

Tuesday, January 31, 2006, 2:04:08 PM, you wrote:

> On Mon, 2006-01-30 at 23:34 -0800, Andrew Morton wrote:

>> All of these only seem to affect a small minority of machines.

> Andrew, I think you really mean here "a small minority of those that
> reported it".  Remember that for ever bug that is reported, there's
> probably 100 cases of that same bug that isn't reported. If not more.
If among 1000 thousand computers with 2.6.15, and 2.6.15-rcX reported
by klive.cpushare.com are 20 that are affected, you might say that
among 150.000 computers registered http://counter.li.org/ there
are almost 3100 computers affected.

Yeah, a minority, but when you count them up it sums up to a hefty
number of admins or just users that hit a bug and do not know what
is going on.

Andrea Arcangeli's klive could some day be a measure of the bug-affected
fraction. If it already is not. Klive reports hardware setups
and configuration. I am not sure if it is available somehow but
maybe it would be nice to query klive database in an SQL manner?

> SELECT COUNT(*) from hosts WHERE kernel = "2.6.15" and config_scsi = 'y'
and ...;
> 3089

-- 
Best regards,
Maciej


