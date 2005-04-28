Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVD1Hiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVD1Hiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVD1Hip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:38:45 -0400
Received: from fmr17.intel.com ([134.134.136.16]:1498 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262128AbVD1HiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:38:24 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050428002254.461fcf32.akpm@osdl.org>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050428002254.461fcf32.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1114673725.26367.7.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 28 Apr 2005 15:35:25 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:22, Andrew Morton wrote:
> 
> On ia64, with tiger_defconfig:
> 
> kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
> : undefined reference to `disable_nonboot_cpus'
> kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
> : undefined reference to `enable_nonboot_cpus'
> kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
> : undefined reference to `enable_nonboot_cpus'
Pavel,
Could IA64 do software suspend? There possibly are other troubles here.

Thanks,
Shaohua

