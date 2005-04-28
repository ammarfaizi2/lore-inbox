Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVD1VEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVD1VEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVD1VEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:04:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27050 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262270AbVD1VDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:03:47 -0400
Date: Thu, 28 Apr 2005 23:03:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Happe <news_0403@flatline.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system reboot after reading /proc/acpi/battery/../state
Message-ID: <20050428210331.GA12597@elf.ucw.cz>
References: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnd6v9ir.b61.news_0403@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a regression to report: my notebook (HP Compaq nx7000) reboots
> after reading /proc/acpi/battery/C11F/state. It's pseudo -
> reproduceable, occurs around every second access.
> 
> please contact me for further information (and what information would be
> needed to fix this bug), I will try to compile older kernel versions to
> find the corresponding acpi update  this annoying bug (but it happens
> for at least one month by now).

Add printks to see where it reboots... it may be faster than binary
searching acpi updates.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
