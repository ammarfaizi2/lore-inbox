Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVBLUzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVBLUzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVBLUzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 15:55:43 -0500
Received: from math.ut.ee ([193.40.5.125]:15290 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261205AbVBLUy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 15:54:27 -0500
Date: Sat, 12 Feb 2005 22:54:25 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: reboot hangs on Toshiba Satellite 1800 laptop
Message-ID: <Pine.SOC.4.61.0502122247410.7963@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be an old problem (google tells it was the same in 2.2 
kernels) but now it troubles me. I have a laptop, Toshiba Satellite 1800 
(Celeron 1.1 GHz, ALi chipset). It works fine but rebooting from linux 
always hangs the machine hard. The last thing seen is "Rebooting", after 
thatt the screen goes black, fan turns on and nothing more happens. I 
can press and hold the power button for 5 seconds and the it powers off 
and I can power it on and work as usual.

I'm running 2.6.11-rc3+BK.

Tried booting with acpi=off, noapic, noapic+nolapic, lapic - no go.
This laptop has local APIC turned off by BIOS so I tried the following 
kernel boot options with both lapic and without lapic: reboot=w, 
reboot=c, reboot=b, reboot=h. Still hangs.

There is a hint in google tyhat turning off APIC cures it but it does 
not seem to work for me.

Any ideas?

-- 
Meelis Roos (mroos@linux.ee)
