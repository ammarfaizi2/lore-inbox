Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbUCMVnE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 16:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUCMVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 16:43:04 -0500
Received: from bender.bawue.de ([193.7.176.20]:57044 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S263194AbUCMVnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 16:43:02 -0500
From: Joerg Sommrey <jo@sommrey.de>
Date: Sat, 13 Mar 2004 22:42:55 +0100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: NMI watchdog in 2.6.3-mm4/2.6.4-mm1
Message-ID: <20040313214255.GA4205@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in my box (Tyan Tiger MPX / 2x AMD Athlon) the NMI watchdog never worked
on any kernel that I tried (2.4.x, 2.6.x). I always found:
| activating NMI Watchdog ... done.
| testing NMI watchdog ... CPU#0: NMI appears to be stuck!

But there is one exception: 2.6.3-mm4 shows:
| activating NMI Watchdog ... done.
| testing NMI watchdog ... OK.

[2.6.3-mm4 was the only -mmX kernel I tried so far.]

With 2.6.4-mm1 the NMI watchdog is again not functional in my box. Any
ideas?

-jo

-- 
-rw-r--r--    1 jo       users          80 2004-03-13 21:46 /home/jo/.signature
