Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbUKNMMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUKNMMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 07:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKNMMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 07:12:08 -0500
Received: from aun.it.uu.se ([130.238.12.36]:42653 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261292AbUKNML5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 07:11:57 -0500
Date: Sun, 14 Nov 2004 13:11:20 +0100 (MET)
Message-Id: <200411141211.iAECBKco011487@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: stsp@aknet.ru, zwane@linuxpower.ca
Subject: Re: 2.6.10-rc1-mm5
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004 01:47:50 +0300, Stas Sergeev wrote:
>Zwane Mwaikambo wrote:
>>> 1. Local APIC stopped working. I know
>> Could you please apply the following patch and supply full dmesg?
>Done.
>Does this help?
...
>ACPI: DSDT (v001   ASUS      K7M 0x00001000 MSFT 0x0100000b) @ 0x00000000
...
>Detected 704.943 MHz processor.
...
>CPU0: AMD Athlon(tm) Processor stepping 02

Please post the contents of /proc/cpuinfo. The age
of this system makes me suspect it may not actually
have a local APIC (the first K7 model didn't have one).

If a previous kernel successfully found the local APIC,
then please state which one and post its boot log.
(And please use nmi_watchdog=2 so we can confirm that
it's there and working.)

/Mikael
