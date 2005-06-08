Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbVFHFZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbVFHFZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVFHFZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:25:57 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:53833 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S262103AbVFHFZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:25:48 -0400
Message-ID: <42A68159.9050808@bigpond.net.au>
Date: Wed, 08 Jun 2005 15:25:45 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [ANNOUNCE][RFC] PlugSched-5.1 for 2.6.12-rc6 and 2.6.12-rc6-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Wed, 8 Jun 2005 05:25:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch of PlugSched-5.1 for 2.6.12-rc5 applies cleanly to 2.6.12-rc6 
and is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-for-2.6.12-rc5.patch?download>

A (new) patch for 2.6.12-rc6-mm1 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.1-for-2.6.12-rc6-mm1.patch?download>

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
