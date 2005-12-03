Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVLCUsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVLCUsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 15:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVLCUsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 15:48:00 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:6595 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932072AbVLCUsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 15:48:00 -0500
Subject: 2.6.14-rt21 & evolution
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 12:47:46 -0800
Message-Id: <1133642866.16477.11.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo... just a heads up. I've been running 2.6.14-rt21 for a few days
and the timing issues seem to be gone on my X2 machine, as the main
timing is no longer derived from the TSC's. Very good! It should work
great with a patched Jack (that does not use TSC for its internal timing
measurements). 

But I'm seeing a recurrent problem that so far I can only blame -rt21
for. When I start evolution (on a fully patched 32 bit fc4 system) it
eventually dies. I'm sorry I don't have more information on exactly what
is happening and I know this report is not very useful. The crash seems
related to reading email (when there's a lot of it) at the same as it is
storing folders and doing other things. After starting it again a couple
of times it keeps working fine for the rest of the day. I'm now at home
with a cold so I have not been able to reboot into the previous kernel
to double check but I wanted to warn you anyway... (I don't see anything
on the logs).

The kernel I was running successfully before (by setting the clock
source manually to acpi_pm) was 2.6.14-rt13.

-- Fernando


