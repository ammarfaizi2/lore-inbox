Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUGEVKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUGEVKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUGEVKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:10:15 -0400
Received: from math.ut.ee ([193.40.5.125]:29950 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262329AbUGEVKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:10:09 -0400
Date: Tue, 6 Jul 2004 00:10:02 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Len Brown <len.brown@intel.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: rtc: IRQ 0 is not free.
In-Reply-To: <1089052420.15675.21.camel@dhcppc4>
Message-ID: <Pine.GSO.4.44.0407060003330.18649-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it would be good if you could verify that vanilla 2.6.7 puts
> rtc on IRQ8 properly for this box.

It was actually a configuration option of HPET that mucked with RTC
IRQs, not ACPI.

> hmmm, had never heard of lspnp (and neither does my local system)

In Debian it's in the pcmcia-cs package.

-- 
Meelis Roos (mroos@linux.ee)

