Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVDDIsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDDIsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDDIsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:48:19 -0400
Received: from fmr19.intel.com ([134.134.136.18]:38380 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261182AbVDDIsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:48:04 -0400
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: ncunningham@cyclades.com
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
	 <20050403193750.40cdabb2.akpm@osdl.org>
	 <1112582553.4194.349.camel@sli10-desk.sh.intel.com>
	 <20050403194807.32fd761a.akpm@osdl.org>
	 <1112582947.4194.352.camel@sli10-desk.sh.intel.com>
	 <1112601670.3757.6.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Message-Id: <1112604263.4194.367.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 16:44:23 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:01, Nigel Cunningham wrote:
> Hi.
> 
> I'm switching suspend2 to use hotplug too. Li, I'll try adding your
> patches as well as Zwane's if you like 
Great!

> (suspend2 can enter S3, S4 or S5
> after writing the image). I'd love to try it on my HT desktop, and
> hotplug will get more testing too :>
Unfortunately, my patches break Pavel's swsusp SMP, as my patches break
current 'cpu_up' mechanism. S4 doesn't require to boot AP CPUs from real
mode.

Thanks,
Shaohua

