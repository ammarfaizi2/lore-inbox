Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281490AbRKHJRl>; Thu, 8 Nov 2001 04:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281486AbRKHJRc>; Thu, 8 Nov 2001 04:17:32 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:9434 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S281496AbRKHJRS>;
	Thu, 8 Nov 2001 04:17:18 -0500
Date: Thu, 8 Nov 2001 09:16:43 +0000 (GMT)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: WOL stops working on halt
Message-ID: <Pine.LNX.4.21.0111080908260.20023-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have a 3c980 NIC plugged into an Abit KT7-RAID and connected together
with a WOL cable. I can't seem to get WOL to work using the ether-wake
utility if I power the box down with shutdown(8). The only way I can
currently get WOL to work is if I reboot the box, then physically press
the power button to turn it off.

I'm loading the 3c59x.o driver using the enable_wol option, but I'm not
currently using ACPI. Looking through the 3c59x.c code, I notice it relies
on the box being put into a certain ACPI state. Will the ACPI code do this
on shutdown?

Cheers

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy."

