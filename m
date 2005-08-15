Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVHOEqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVHOEqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 00:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVHOEqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 00:46:30 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:62329 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750811AbVHOEq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 00:46:29 -0400
Message-ID: <43001E18.8020707@bigpond.net.au>
Date: Mon, 15 Aug 2005 14:46:16 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: [ANNOUNCE][RFC] PlugSched-5.2.4 for 2.6.12 and 2.6.13-rc6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 15 Aug 2005 04:46:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version contains minor bug fixes and improvements to the zaphod 
scheduler including changes to the default configuration parameters that 
take into account the results of tests using Con Kolivas's new (and very 
useful) interbench benchmark tool.

A patch from Plugsched-5.2.3 to PlugSched-5.2.4 for 2.6.12 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.3-to-5.2.4-for-2.6.12.patch?download>

and a full patch for 2.6.13-rc6 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.4-for-2.6.13-rc6.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills or zaphod.  If you don't change the
default when you build the kernel the default scheduler will be
ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
