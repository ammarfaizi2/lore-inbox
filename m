Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVC1S5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVC1S5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVC1S5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:57:06 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:31879 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262008AbVC1S4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:56:41 -0500
X-ME-UUID: 20050328185638659.A0F9C1C003F5@mwinf0804.wanadoo.fr
Subject: Various issues after rebooting
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Mon, 28 Mar 2005 21:56:39 +0200
Message-Id: <1112039799.6106.16.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm facing some various odd issues with a AMD64 based laptop (Compaq
R3480EA) I bought recently.

On first boot, everything is all right. The laptop runs flawlessly. But
if I shutdown the laptop and restart it, I can see all kind of strange
things happening.

1) the system clock runs 3 times faster,
2) the system is unable to mount cdroms,
3) modprobing nidswrapper cause a whole system freeze with the following
message:

CPU 0: Machine Check Exception: 0000000000000004
Bank 4: b200000000070f0f
Kernel panic - not syncing: CPU context corrupt

I've tried with various kernels and distributions in 32bit and 64bit
modes but that make no differences.

I also tried disable ACPI, setting clock=[tsc|pmtmr|pti], diabling APIC,
etc. No luck. No matter how many reboots I do, the problem remains. The
only way to fix the problem is to keep the laptop off for a couple of
hours.

I thought of a hardware issue, but in WinXP, everything is fine. And in
the case of a hardware issue, I guess the problem would always show, not
just in Linux after a reboot. 

My guess is that the BIOS doesn't re-initialize the hardware correctly
in case of a quick shutdown/reboot but WinXP might be initializing the
things by itself (it's a guess, I'm probably completely wrong).

Does that make any sense so someone? How could I help tracking down this
issue?

Thanks in advance,

Best regards,
Olivier.


