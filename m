Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWJ0RPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWJ0RPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWJ0RPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:15:10 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2710 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751167AbWJ0RPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:15:09 -0400
Subject: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, john stultz <johnstul@us.ibm.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 13:15:08 -0400
Message-Id: <1161969308.27225.120.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Someone recently pointed out to me that a Windows "CPU driver update"
supplied by AMD fixes the unsynced TSC problem on dual core AMD64
systems.

http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_871_13118,00.html

"The AMD Dual-Core Optimizer can help improve some PC gaming video
performance by compensating for those applications that bypass the
Windows API for timing by directly using the RDTSC (Read Time Stamp
Counter) instruction. Applications that rely on RDTSC do not benefit
from the logic in the operating system to properly account for the
affect of power management mechanisms on the rate at which a processor
core's Time Stamp Counter (TSC) is incremented. The AMD Dual-Core
Optimizer helps to correct the resulting video performance effects or
other incorrect timing effects that these applications may experience on
dual-core processor systems, by periodically adjusting the core
time-stamp-counters, so that they are synchronized."

What are the chances of Linux getting a similar fix?

Lee

