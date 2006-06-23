Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWFWUYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWFWUYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbWFWUYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:24:18 -0400
Received: from khc.piap.pl ([195.187.100.11]:466 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1752023AbWFWUYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:24:17 -0400
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Jean Delvare" <khali@linux-fr.org>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix cpufreq_{conservative,ondemand} compilation
References: <EB12A50964762B4D8111D55B764A84541D47D3@scsmsx413.amr.corp.intel.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 23 Jun 2006 22:24:13 +0200
In-Reply-To: <EB12A50964762B4D8111D55B764A84541D47D3@scsmsx413.amr.corp.intel.com> (Venkatesh Pallipadi's message of "Fri, 23 Jun 2006 10:20:23 -0700")
Message-ID: <m3y7vnei36.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

> Thanks for the patch. Yes, I had missed this warning as some other patch
> in my local tree was adding cpu.h to cpufreq_ondemand.c

BTW: why can't we have "ondemand" (and others) by default (only
"performance" or "userspace")?
-- 
Krzysztof Halasa
