Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVFEFmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVFEFmc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 01:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFEFmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 01:42:32 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:38052 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261461AbVFEFm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 01:42:28 -0400
Message-ID: <42A290C1.1050106@bigpond.net.au>
Date: Sun, 05 Jun 2005 15:42:25 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [ANNOUNCE][RFC] PlugSched-5.1 for 2.6.11, 2.6.12-rc5 and 2.6.12-rc5-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Sun, 5 Jun 2005 05:42:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch to upgrade PlugSched-5.0 to PlugSched-5.1 (containing ingosched, 
nicksched, staircase, spa_no_frills and zaphod CPU schedulers) against a 
2.6.11 kernel is available for download from:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.0-to-5.1-for-2.6.11.patch?download>

A patch of PlugSched-5.1 for 2.6.12-rc5 is at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-for-2.6.12-rc5.patch?download>

and for 2.6.12-rc5-mm2 at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-for-2.6.12-rc5-mm2.patch?download>

Version 5.1 contains bug fixes for spa_no_frills and zaphod, upgrade of 
staircase to version 11.2 and the recent changes Con Kolivas's "nice" 
aware load balancing patch.

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
