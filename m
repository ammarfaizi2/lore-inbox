Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUFRPnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUFRPnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUFRPnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:43:02 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:60669 "EHLO
	damned.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265212AbUFRPke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:40:34 -0400
To: linux-kernel@vger.kernel.org
Subject: acpi S3 never wakes up
Message-Id: <20040618154025.15708106@damned.travellingkiwi.com>
Date: Fri, 18 Jun 2004 16:40:25 +0100 (BST)
From: hamish@travellingkiwi.com (Hamie)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

I have an IBM r50p that I'd really really really like to have ACPI usable on. The battery works fine, the temp shows fine, the processor speeds up & slows down. All great, until I try to suspend (to RAM or to disk).

Firstly to RAM.

I hit Fn=F4 (Or cat 3 > /proc/acpi/sleep). System says I'm suspending. & goes to sleep. Fine so far. Unlike APM, the Fn key doesn't wake it up any more, so I press the power button. It LOOKS like it's starting up again, fan starts, CD spins, but no display... Doesn't matter whether I'm running X, or from the console. After wakup, nothing seems to work. Fn-F4 will send me to sleep again though... CTRL-ALT-Fx, does nothing...

Now should I get the lock icon again (I lock my machine with a poweron pass BIOS + Disk, NOT supervisor) like on APM? Or not? SHould I come up directly back where I was before? Or something else? Anyone know? I've seen reference to people having success, but I've had nothing but bad luck with ACPi & suspending so far.

Anyone got any ideas? I really really really hate having to boot my laptop 3x a day...

Oh. I've tried all kinds of kernels. Current is 2.6.6 and 2.6.7, both do exactly the same thing.

TIA

Hamish., 
