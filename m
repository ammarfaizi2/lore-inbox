Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTJWUJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTJWUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11719 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261784AbTJWUIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:14 -0400
Date: Thu, 23 Oct 2003 16:17:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 3/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031023141703.GG643@openzaurus.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60077914@scsmsx403.sc.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Patch 3/3: New dynamic cpufreq driver (called 
> DemandBasedSwitch driver), which periodically monitors CPU 
> usage and changes the CPU frequency based on the demand.
> 
> diffstat dbs3.patch 
> drivers/cpufreq/Kconfig       |   25 ++++
> drivers/cpufreq/Makefile      |    1 
> drivers/cpufreq/cpufreq_dbs.c |  214
> 
Could you name it cpufreq_demand? We have enough
TLAs as is.
				Pavwl


-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

