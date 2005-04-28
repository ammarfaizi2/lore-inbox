Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVD1IMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVD1IMn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVD1IM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:12:29 -0400
Received: from fmr17.intel.com ([134.134.136.16]:21473 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261959AbVD1ILT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:11:19 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [ACPI] Re: [PATCH 6/6]suspend/resume SMP support
Date: Thu, 28 Apr 2005 16:11:00 +0800
User-Agent: KMail/1.6.1
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "ACPI-DEV" <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>,
       "Zwane Mwaikambo" <zwane@linuxpower.ca>
References: <20050428074201.GA1906@elf.ucw.cz>
In-Reply-To: <20050428074201.GA1906@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200504281611.00254.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 15:42, Pavel Machek wrote:
> Hi!
>
>  > > On ia64, with tiger_defconfig:
>  > >
>  > > kernel/built-in.o(.text+0x59e12): In function `suspend_prepare':
>  > > : undefined reference to `disable_nonboot_cpus'
>  > >
>  > > kernel/built-in.o(.text+0x59e62): In function `suspend_prepare':
>  > > : undefined reference to `enable_nonboot_cpus'
>  > >
>  > > kernel/built-in.o(.text+0x5a222): In function `suspend_finish':
>  > > : undefined reference to `enable_nonboot_cpus'
>  >
>  > Pavel,
>  > Could IA64 do software suspend? There possibly are other troubles here.
>
>  Someone would have to write low-level support. Bring me ia64 notebook
>  and I'll do it ;-)))))))))))))))))))).
>                                                                  Pavel

I just checked DSDT on one ia64 box, it has S0, S4, S5 object.
So, the platform should have sufficient support for sleep-to-disk.

Thanks,
Luming
