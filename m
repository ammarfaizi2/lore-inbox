Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTHSHWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 03:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTHSHWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 03:22:52 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:42675 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262116AbTHSHWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 03:22:51 -0400
Subject: RE: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
From: Stian Jordet <liste@jordet.nu>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Message-Id: <1061277778.3952.2.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 09:22:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 19.08.2003 kl. 03.15 skrev Brown, Len:
> CONFIG_ACPI_HT is mostly just an alias for CONFIG_ACPI_BOOT -- the early
> boot part of ACPI without the run-time events included in the full ACPI
> implementation.  Unless I screwed up the config dependencies, it should
> be impossible to enable the full CONFIG_ACPI without including
> CONFIG_ACPI_HT.

Hmm. I just ran "make oldconfig" and when I got the question about
"CONFIG_ACPI_HT" I just chose no, since I don't have HT. When I _now_
look at it with "make menuconfig" I ofcourse see that without the first,
I never get the latter one, but that was really non-obvious. But thanks
:)

Best regards,
Stian

