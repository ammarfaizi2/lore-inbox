Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVD1Hos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVD1Hos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVD1HoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:44:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:25057 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262129AbVD1HmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:42:20 -0400
Date: Thu, 28 Apr 2005 09:42:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050428074201.GA1906@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <20050428002254.461fcf32.akpm@osdl.org> <1114673725.26367.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114673725.26367.7.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On ia64, with tiger_defconfig:
> > 
> > kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
> > : undefined reference to `disable_nonboot_cpus'
> > kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
> > : undefined reference to `enable_nonboot_cpus'
> > kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
> > : undefined reference to `enable_nonboot_cpus'
> Pavel,
> Could IA64 do software suspend? There possibly are other troubles here.

Someone would have to write low-level support. Bring me ia64 notebook
and I'll do it ;-)))))))))))))))))))).
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
