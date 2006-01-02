Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWABS6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWABS6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWABS6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:58:00 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:13257 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750957AbWABS57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:57:59 -0500
Date: Mon, 2 Jan 2006 19:57:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dianogsing a hard lockup
In-Reply-To: <Pine.LNX.4.61.0512310038240.32485@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0601021955590.29938@yvahk01.tjqt.qr>
References: <5kMWZ-2PF-7@gated-at.bofh.it> <43A451C8.9090304@shaw.ca>
 <Pine.LNX.4.61.0512310038240.32485@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>> Try nmi_watchdog=1 on the kernel command line. That may get you a stack trace
>> for the lockup.
>
>That does not seem to work.
>APIC is enabled, but the kernel reports "No local APIC present or hardware 
>disabled". /proc/interrupts only lists XT PICs, and the NMI counter in 
>interrupts is also 0.

So, here's a potential answer to my own problem: the mainboard is crap.
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] 
(rev 04)
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 23)



Jan Engelhardt
-- 
