Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262880AbUCRS33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbUCRS33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:29:29 -0500
Received: from fmr04.intel.com ([143.183.121.6]:54705 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262876AbUCRS3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:29:23 -0500
Message-Id: <200403181829.i2IITEF10447@unix-os.sc.intel.com>
From: "Kenneth Chen" <kenneth.w.chen@intel.com>
To: "'Dominik Brodowski'" <linux@dominikbrodowski.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-ia64@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "CPU Freq ML" <cpufreq@www.linux.org.uk>
Subject: RE: add lowpower_idle sysctl
Date: Thu, 18 Mar 2004 10:29:13 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040318090522.GC15526@dominikbrodowski.de>
Thread-Index: AcQMyDSUbmMYXggVSnWIaNwiCdFlWgATg1Dg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Dominik Brodowski wrote on Thu, March 18, 2004 1:05 AM
> I assume ia64 does idling using the ACPI processor.c driver?

No, not really.

> If so, couldn't writing to /proc/acpi/processor/./power be
> an option?

Not all platform has ACPI support, so going through ACPI isn't
generic enough.


