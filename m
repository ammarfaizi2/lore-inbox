Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUITQZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUITQZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUITQZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:25:34 -0400
Received: from fmr04.intel.com ([143.183.121.6]:32650 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266741AbUITQZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:25:31 -0400
Date: Mon, 20 Sep 2004 09:25:20 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Len Brown <len.brown@intel.com>,
       ACPI Developer <acpi-devel@lists.sourceforge.net>,
       LHNS list <lhns-devel@lists.sourceforge.net>
Cc: Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PATCH-ACPI based CPU hotplug[0/6]
Message-ID: <20040920092520.A14208@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,
  I am resending the following set of patches which support ACPI based physical 
CPU hotplug for IA64 platform, after having including all the community 
feedback(of course I got very thin feedback) which I got on 
acpi-devel mailing list.

This set of patches has been tested on linux-2.6.9-rc2. Also this time I am 
cc'ing ia64/lkml mailing lists as patch 3/6 and patch 4/6 touches arch specific files.

Details:(Applies cleanly onto linux-2.6.9-rc2)
Patch[1/6]- Core ACPI enhancement support
Patch[2/6]- ACPI hotplug eject interface support
Patch[3/6]- Arch specific support for mapping lsapic to cpu
Patch[4/6]- Dynamic cpu registration and unregistration support
Patch[5/6]- Extend ACPI processor driver to support Hotplug
Patch[6/6]- ACPI container driver(New driver)

Please consider applying this patch onto your test tree.

Thanks,
Anil S Keshavamurthy
