Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVLUWK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVLUWK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVLUWK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:10:58 -0500
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:29138 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S932302AbVLUWK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:10:57 -0500
Date: Wed, 21 Dec 2005 14:09:13 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfctr-devel@lists.sourceforge.net
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: new 2.6.15-rc6 perfmon2 patch
Message-ID: <20051221220913.GC8275@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051215104604.GA16937@frankl.hpl.hp.com> <20051220180744.GC5516@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220180744.GC5516@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have released YET another version of the perfmon2 new code base.
This one is STILL relative to 2.6.15-rc6 and is called 2.6.15-rc6-v2.
This one DOES fix the panic on pfm_fmt_put()!

This patch includes compared to initial 2.6.15-rc6:

    - quick overview of perfmon2 README

    - fix the kernel panic on pfm_fmt_put()

    - save/restore of PMU state when NMI watchdog is
      enabled.

    - reinforced  checks in register_smpl_fmt()

    - revised checks to detect if a format/PMU description is
      builtin or module

    - sampling formats can now export the notification
      message queue depth they require.

    - MIPS patch updated to latest fixes.

You MUST use libpfm-3.2-051215 with this kernel due to
interface change for pfm_create_context().
As usual, you can download the latest packages from the
SourceForge website at:

http://www.sf.net/projects/perfmon2

This will hopefully be the last release for this year.

Happy Holidays.

-- 
-Stephane
