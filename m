Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVD1E43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVD1E43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 00:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVD1E43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 00:56:29 -0400
Received: from fmr17.intel.com ([134.134.136.16]:62388 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261951AbVD1E41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 00:56:27 -0400
Subject: Re: system reboot after reading /proc/acpi/battery/../state
From: Li Shaohua <shaohua.li@intel.com>
To: Andreas Happe <news_0403@flatline.ath.cx>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
References: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1114664026.22110.37.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 12:53:46 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-27 at 22:48, Andreas Happe wrote:
> Hi,
> I have a regression to report: my notebook (HP Compaq nx7000) reboots
> after reading /proc/acpi/battery/C11F/state. It's pseudo -
> reproduceable, occurs around every second access.
> 
> please contact me for further information (and what information would be
> needed to fix this bug), I will try to compile older kernel versions to
> find the corresponding acpi update  this annoying bug (but it happens
> for at least one month by now).
Unloading the watchdog driver (the TCO driver) will help you.

Thanks,
Shaohua

