Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVHNKWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVHNKWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 06:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVHNKWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 06:22:08 -0400
Received: from lucidpixels.com ([66.45.37.187]:39303 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932478AbVHNKWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 06:22:07 -0400
Date: Sun, 14 Aug 2005 06:21:57 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Question regarding HPET the 2.6 series kernel.
Message-ID: <Pine.LNX.4.63.0508140619320.5070@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[*] HPET Timer Support
[*]   Provide RTC interrupt

[*] HPET - High Precision Event Timer
[*]   Allow mmap of HPET

http://tlug.up.ac.za/guides/lkcg/arch_i386.html

HPET Timer Support	HPET_TIMER
This enables the use of the HPET for the kernel's internal timer. HPET is 
the next generation timer replacing legacy 8254s. You can safely choose Y 
here. However, HPET will only be activated if the platform and the BIOS 
support this feature. Otherwise the 8254 will be used for timing services. 
Choose N to continue using the legacy 8254 timer.

How do I determine if my BIOS has this feature?

$ dmesg | grep -i hpet
$ dmesg | grep -i 8254
$ dmesg | grep -i timer
..TIMER: vector=0x31 pin1=2 pin2=-1
PCI: Setting latency timer of device 0000:02:01.0 to 64
$

Assuming it does, is there any reason to use or not to use this feature?

Thanks,

Justin.

