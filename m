Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTA2IAA>; Wed, 29 Jan 2003 03:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265243AbTA2IAA>; Wed, 29 Jan 2003 03:00:00 -0500
Received: from fmr02.intel.com ([192.55.52.25]:34784 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265222AbTA2H77>; Wed, 29 Jan 2003 02:59:59 -0500
Date: Wed, 29 Jan 2003 16:06:21 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Scott Murray <scottm@somanetworks.com>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: Questions about CPCI Hot Swap driver.
Message-ID: <Pine.LNX.4.44.0301291550500.10354-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Scott
I have some questions about your CPCI Hot Swap driver.
Would you mind helping me to clarify them ?
1. Why need we clear the EXT bit in the HS_CSR in "disable_slot()"?
I think the EXT bit has not been set at this point.
2. I wonder why we could not receive the #ENUM interrupt when we unpluged
the board after disabling the corresponding slot("echo 0 > power")? It 
seems that the cpci_led_on has some mysterious side effect, but I could 
not find any hints in the spec.
Could you help me?
Thanks in advance.

Best Regards,
-Stan
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


