Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbVKXXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVKXXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVKXXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:12:56 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:6733 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932667AbVKXXMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:12:55 -0500
Message-ID: <438648F5.2010706@bigpond.net.au>
Date: Fri, 25 Nov 2005 10:12:53 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: [ANNOUNCE][RFC] PlugSched-6.1.5 for 2.6.14, 2.6.15-rc2 and 2.6.15-rc2-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 24 Nov 2005 23:12:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version has a modified (hopefully improved) configuration mechanism.

A patch for 2.6.15-rc2-mm1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.5-for-2.6.15-rc2-mm1.patch?download>

and a patch to upgrade the 6.1.4 versions for 2.6.14 and 2.6.15-rc2 to 
6.1.5 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.4-to-6.1.5-for-2.6.15-rc2.patch?download>

Very Brief Documentation:

You can select a default scheduler at kernel build time.  If you wish to
boot with a scheduler other than the default it can be selected at boot
time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched,
nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
don't change the default when you build the kernel the default scheduler
will be ingosched (which is the normal scheduler).

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
