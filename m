Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSILPLc>; Thu, 12 Sep 2002 11:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSILPLc>; Thu, 12 Sep 2002 11:11:32 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:10415 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S316089AbSILPLb>; Thu, 12 Sep 2002 11:11:31 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DE4E@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Soos Peter'" <sp@osb.hu>, linux-kernel@vger.kernel.org
Subject: RE: APM & ACPI detect
Date: Thu, 12 Sep 2002 08:16:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Soos Peter [mailto:sp@osb.hu] 
> Are there any "official way" to detect that APM or ACPI is active?
> 
> With APM I try it and it works:
> 
> #ifdef CONFIG_APM
> #include <linux/apm_bios.h>
> #endif
> 
> ...
> 
> #ifdef CONFIG_APM
> if (apm_info.disabled >= 0) {
>                 printk(KERN_NOTICE "Real APM support is present.\n");
> }
> #endif
> 
> Are there any similar for ACPI?

Well there's pm_active, which is 1 if either is on. Is this really what you
want?

Regards -- Andy
