Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIJJJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIJJJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVIJJJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:09:25 -0400
Received: from smtp10.poczta.onet.pl ([213.180.130.52]:3565 "EHLO
	smtp10.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S1750715AbVIJJJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:09:24 -0400
Date: Sat, 10 Sep 2005 11:04:41 +0200
From: Michal Kepien <lordpopcorn@poczta.onet.pl>
To: linux-kernel@vger.kernel.org
Subject: Kernels >= 2.6.13 + ldconfig on boot = system lockup (2.6.12.5
 works fine)
Message-Id: <20050910110441.586a1e89.lordpopcorn@poczta.onet.pl>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there all kernel hackers,

I'm using Slackware 10.1 + current on my box and the 2.6 kernel series has been
working fine until 2.6.13 has shown up. One thing Slackware does upon bootup is
running /sbin/ldconfig to update the shared library links. When I upgraded my
kernel to version 2.6.13, the ldconfig step locks my system - no keyboard
response, I'm not even able to log in via SSH - only a hard reset helps. Don't
know whether it's any hint, but the HDD led on my chassis' front panel is lit
permanently when ldconfig is run. When I boot the 2.6.12.5 kernel, everything
works just fine. I've also got a Toshiba laptop using Slackware 10.1 + current
too and 2.6.13 works fine! I'd support you with more information but actually I
don't quite know how to obtain them - there is nothing in the system logs. Any
hints would be greatly appreciated, if you need more details - just ask me and
I'll do what I can.

Below is my hardware configuration:

Abit BE6 mainboard
Celeron 700 (Coppermine)
64 MB RAM
IBM 12 GB HDD
S3 Savage4 32 MB

-- 
Best regards,
Michal
