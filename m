Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUJNSpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUJNSpB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUJNSn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:43:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:32750 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267170AbUJNSGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:06:42 -0400
Subject: ACPI hangs at boot  w/ nForce motherboard
From: john stultz <johnstul@us.ibm.com>
To: Len Brown <len.brown@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1097777194.20778.8.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 14 Oct 2004 11:06:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Len,
	Sorry for the lack of details here, but I figured I should at least let
you know. On my box at home (nForce1 motherboard w/ voodoo3 video)
2.6.9-rcX kernels hang on boot. Since its my personal system, I haven't
had much time to debug or look into the issue, however I have found that
acpi=off allows me to boot. 

There are no strange error messages, the system just hangs (the
framebuffer console looks to be locked at well - no blinking cursor). 

Any suggestions?  I plan to try the standard acpi=noirq, and pci=noacpi,
but I feel like I tried them awhile ago to no effect.

thanks
-john

