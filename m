Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWAXEuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWAXEuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 23:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWAXEuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 23:50:24 -0500
Received: from ns.amrita.ac.in ([203.197.150.194]:35211 "EHLO
	bhadra.amrita.ac.in") by vger.kernel.org with ESMTP
	id S1030333AbWAXEuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 23:50:22 -0500
X-Antivirus-AMRITA-Mail-From: harish@arl.amrita.edu via bhadra.amrita.ac.in
X-Antivirus-AMRITA: 1.25-st-qms (Clear:RC:0(203.197.150.195):SA:0(-2.6/3.5):. Processed in 0.920205 secs Process 24161)
Message-ID: <43D5B473.3060006@arl.amrita.edu>
Date: Tue, 24 Jan 2006 10:30:35 +0530
From: Harish K Harshan <harish@arl.amrita.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DMA Transfer problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   Im having problems with DMA transfer on Linux, for an ADC card. The 
card is AxiomTek AX5621H, and can use DMA channels 1 and 3. I tried both 
the channels, but the DMA transfers are irregular (i.e.) at different 
speeds (which of course is not acceptable, since that application is 
time critical). The device driver (which I wrote) seems to work fine for 
all the other systems I tried it on. But this problem occurs only on one 
particular model of computer (Chino-Laxsons Pentium-4 boards). I tried 
another system with the same configuration, but the same resulted. After 
some time of execution, I get the kernel panic screen, which says the 
CPU context is corrupt. Please help me with this problem, as I need to 
get this driver working somehow on the P4 systems. I tried the Redhat-9 
kernel (2.4.20-8) and the debian kernel too (2.2.20).... gave the same 
results.

Thanks in advance,
Harish.
