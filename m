Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUAVTzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUAVTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:55:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:29575 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266428AbUAVTzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:55:16 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
	 <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
	 <1074709166.16374.73.camel@cog.beaverton.ibm.com>
	 <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074800554.21658.68.camel@cog.beaverton.ibm.com>
	 <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074801242.21658.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 11:54:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 11:50, timothy parkinson wrote:
> well, it does *say* the following:
> 
>   ..... host bus clock speed is 133.0266 MHz.
>   checking TSC synchronization across 2 CPUs: passed.
>   Starting migration thread for cpu 0

That looks fine then. 

> is there a good way to check IDE PIO?

Run  "/sbin/hdparm /dev/hdX" and look for "using_dma = 0".

thanks
-john




