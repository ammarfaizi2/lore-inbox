Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUHXWrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUHXWrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269093AbUHXWrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 18:47:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:47789 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269092AbUHXWrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 18:47:49 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824061459.GA29630@elte.hu>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824061459.GA29630@elte.hu>
Content-Type: text/plain
Message-Id: <1093387668.841.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 18:47:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 02:14, Ingo Molnar wrote:
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
> 

modprobe'ing causes this latency:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace1.txt

This one is caused by flood pinging the broadcast address (ping -s 65507
-f $BROADCAST_ADDRESS):

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P9#/var/www/2.6.8.1-P9/trace2.txt

Lee

