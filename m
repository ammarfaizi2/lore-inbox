Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276137AbRI1PkS>; Fri, 28 Sep 2001 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276138AbRI1PkJ>; Fri, 28 Sep 2001 11:40:09 -0400
Received: from relay1.ne.smtp.psi.net ([38.9.153.2]:53656 "EHLO
	relay1.ne.smtp.psi.net") by vger.kernel.org with ESMTP
	id <S276137AbRI1Pjx>; Fri, 28 Sep 2001 11:39:53 -0400
Date: Fri, 28 Sep 2001 11:40:19 -0400
Message-Id: <200109281540.f8SFeJ301139@mojo.ma.radiance>
From: John Ruttenberg <rutt@chezrutt.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 problem with APM on Inspiron 8000
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Inspiron 8k loves kernels 2.4.* up to 2.4.9, but has problems with 2.4.10.
In particular, it seems that any APM event (suspend, etc.) causes a hard
freeze.  In fact, on 2.4.9 and lower, I can even use the function-setup key
which lets me examine/change bios while the kernel is running.  On 2.4.10,
this causes a kernel freeze.

My .config files are essentially identical for 2.4.9 and for 2.4.10.

On thing I noticed that seems a little suspicious is this start up message:

    Local APIC disabled by BIOS -- reenabling.
    Found and enabled local APIC!

For 2.4.9, I get:

    mapped APIC to ffffe000 (01442000)

Both kernels print:

    apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
    ...
    ACPI: APM is already active, exiting
