Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVDDJx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDDJx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 05:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDDJx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 05:53:59 -0400
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:33173 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261200AbVDDJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 05:53:46 -0400
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>
In-Reply-To: <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
	 <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
	 <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
	 <1112604263.4194.367.camel@sli10-desk.sh.intel.com>
	 <20050404091027.GA14765@elf.ucw.cz>
	 <1112606651.4194.391.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1112608527.3757.19.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 04 Apr 2005 19:55:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li.

On Mon, 2005-04-04 at 19:24, Li Shaohua wrote:
> > so that cpu_up mechanism can handle them?
> If S4 also calls a smp_prepare_cpu, then the patches don't break S4. If
> people don't complain warm boot a CPU is slow, I'd like S4 also use
> smp_prepare_cpu.

So you have some more changes? Can I get a monolithic patch to try, when
you're ready?

Thanks!

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

