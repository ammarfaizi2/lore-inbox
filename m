Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271936AbTG2Req (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTG2Req
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:34:46 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:46297 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S271936AbTG2Rep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:34:45 -0400
Date: Tue, 29 Jul 2003 19:34:43 +0200 (MEST)
Message-Id: <200307291734.h6THYhmp012585@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.0-test2 loses time on 486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My old 486 test box is losing time at an alarming rate
when running 2.6.0-test kernels. It loses almost 2 minutes
per hour, less if it sits idle. This problem does not
occur when it's running a 2.4 kernel.

There's nothing noteworthy in dmesg.

This has been going on since at least the 2.5.7x kernels,
and possible also the 2.5.6x kernels. I strongly suspect
a bug in the time-keeping changes in late 2.5 kernels.
The 486 has no TSC, and I don't have an NTP server to
keep my machines' times in sync.

/Mikael
