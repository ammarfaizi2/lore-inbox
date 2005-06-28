Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVF1G1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVF1G1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVF1G0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:26:37 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:9937 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261424AbVF1F7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:59:05 -0400
Message-ID: <42C0E722.5090803@bigpond.net.au>
Date: Tue, 28 Jun 2005 15:58:58 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [ANNOUNCE][RFC] PlugSched-5.2.2 for 2.6.12 and 2.6.12-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Jun 2005 05:58:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PlugSched-5.2.2 is available for 2.6.12 and 2.6.12-mm2 kernels.  This
version applies Con Kolivas's latest modification to his "nice" aware
SMP load balancing patches.

A patch to bring PlugSched-5.2.1 for 2.6.12 to PlugSched-5.2.2 is
available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.1-to-5.2.2-for-2.6.12.patch?download>

A patch for 2.6.12-mm2 is available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-5.2.2-for-2.6.12-mm2.patch?download>

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
