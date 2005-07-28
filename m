Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVG1LIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVG1LIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVG1LIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:08:22 -0400
Received: from webmail1.sd.dreamhost.com ([66.33.201.159]:21227 "EHLO
	webmail1.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S261381AbVG1LIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:08:16 -0400
Message-ID: <20147.195.77.63.25.1122548894.squirrel@webmail.criptos.com>
Date: Thu, 28 Jul 2005 13:08:14 +0200 (CEST)
Subject: Drivers for Ricoh SD Card Reader
From: =?iso-8859-1?Q?Tom=E0s_N=FA=F1ez_Lirola?= <tomas@criptos.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
 I have a Thinpad X40 notebook, with a Ricoh SD Card Reader. This card
reader has not a Linux driver, so I can't use it. Googling I've deduced
nobody can, as everybody notes the same problem with the device.

 The device is not new, as my notebook is one year old. So it's strange we
still don't have a linux driver.

 I'd like to do something about it, and I've asked Ricoh and IBM for some
specs of the device, to try to build the driver. But they only answer
"There is no linux driver, and is not planned to release it."

 Obviously, this answer is useless, but I don't know what to do now... Do
you know if Ricoh has released specs before? Do you think IBM should have
them?

What would you do in my place? Which should be the next step?

Thanks

PD: Please CC me as I'm not subscribed yet to kernel list. Thanks again.
PD2: In case you are curious about the device, here is 'lspci -v'

0000:02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 8d)
        Subsystem: IBM: Unknown device 0555
        Flags: bus master, medium devsel, latency 168, IRQ 16
        Memory at b0000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        16-bit legacy interface ports at 03e1

0000:02:00.1 0805: Ricoh Co Ltd: Unknown device 0822 (rev 13)
        Subsystem: IBM: Unknown device 0556
        Flags: medium devsel, IRQ 17
        [virtual] Memory at d0221000 (32-bit, non-prefetchable) [disabled]
[size=256]
        Capabilities: [80] Power Management version 2

