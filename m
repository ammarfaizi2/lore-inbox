Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSKUVxO>; Thu, 21 Nov 2002 16:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSKUVxO>; Thu, 21 Nov 2002 16:53:14 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:46818 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S264938AbSKUVxN>;
	Thu, 21 Nov 2002 16:53:13 -0500
Subject: Unsupported AGP-bridge on VIA VT8633
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037916067.813.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Nov 2002 23:01:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have an ASUS CUV266-DLS motherboard, with an agp-bridge which I think
is supposed to be supported. But it isn't. This is with 2.4.20-rc1, but
I've tried 2.5.47 as well, and haven't seen anything that should have
changed in 2.4.20-rc2 or 2.5.48. 

Based on agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Unsupported Via chipset (device id: 3091), you might want to
try agp_try_unsupported=1.
agpgart: no supported devices found.

I have tried with agp_try_unsupported=1, but no luck. I have seen that
in pci_ids.h this device id is defined to vt8633, so I suppose it should
work. I would really like to know why it doesn't...

Regards,
Stian Jordet

