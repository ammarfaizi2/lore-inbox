Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVDBLFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDBLFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 06:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDBLFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 06:05:49 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51695 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261378AbVDBLFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 06:05:45 -0500
Date: Sat, 2 Apr 2005 13:05:40 +0200 (MEST)
Message-Id: <200504021105.j32B5eN2018794@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, wingc@engin.umich.edu
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005 18:24:00 -0500 (EST), Christopher Allen Wing wrote:
>I also see messages from the kernel like:
>
>	APIC error on CPU0: 00(40)
>	APIC error on CPU0: 40(40)
>
>so I'd guess that something is wrong in the way that the machine is set
>up. Perhaps the BIOS or ACPI tables are just defective.

Those are "received illegal vector" errors, and they
typically indicate hardware flakiness or BIOS issues.

Could be inadequate power supply, inadequate cooling,
a BIOS bug (please check for updates), a too new CPU
(again, check for a BIOS update), or simply a poorly-
designed mainboard.

/Mikael
