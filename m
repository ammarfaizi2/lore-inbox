Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992462AbWJTC7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992462AbWJTC7w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992464AbWJTC7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:59:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:44931 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S2992462AbWJTC7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:59:51 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,331,1157353200"; 
   d="scan'208"; a="147858097:sNHT18669028"
Subject: Re: ipw2200: "ieee80211: Info elem: parse failed"
From: Zhu Yi <yi.zhu@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com,
       "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <20061019192350.13209920.akpm@osdl.org>
References: <453742AE.3010201@gmail.com>
	 <20061019192350.13209920.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel Corp.
Date: Fri, 20 Oct 2006 10:57:21 +0800
Message-Id: <1161313041.19188.23.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 19:23 -0700, Andrew Morton wrote:
> On Thu, 19 Oct 2006 11:17:34 +0200
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
> > Hi,
> > 
> > since 2.6.19-rc1 I'm getting these messages from ipw2200 driver:
> > ieee80211: Info elem: parse failed: info_element->len + 2 > left : 
> > info_element->len+2=8 left=2, id=128.
> > 
> > The driver says:
> > ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4km
> > ipw2200: Copyright(c) 2003-2006 Intel Corporation
> > ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
> > PCI: setting IRQ 3 as level-triggered
> > ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 3 (level, low) -> IRQ 3
> > ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
> > ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
> > 
> > and works, but the message is annoying, since the driver prints it again and 
> > again. What could be wrong?
> > 
> 
> I suspect it was always failing.  But the failure message has been changed
> so that it actually comes out.

This was already addressed by
http://marc.theaimsgroup.com/?l=linux-netdev&m=116119388014674&w=2

Thanks,
-yi
