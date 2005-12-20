Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVLTSJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVLTSJn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLTSJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:09:43 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:8921 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1750808AbVLTSJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:09:42 -0500
Date: Tue, 20 Dec 2005 10:07:44 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.15-rc6 updated perfmon2 patch
Message-ID: <20051220180744.GC5516@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051215104604.GA16937@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215104604.GA16937@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have released another verison of the perfmon2 new code base.
This one is relative to 2.6.15-rc6 and hopefully should
fix some of the problems people have reported.

This new kernel patch fixes the following:
	- kernel panic in perfmon_pmu.c or perfmon_fmt.c
	  if PMU description or buffer format is compiled in.

	- missing __user in perfmon_syscalls.c

	- better handling of NMI reservation for X86-64, EM64T
	  and i386.

You MUST use libpfm-3.2-051215 with this kernel due to
interface change for pfm_create_context().

As usual, you can download the latest packages from the
SourceForge website at:

	http://www.sf.net/projects/perfmon2

-- 
-Stephane
