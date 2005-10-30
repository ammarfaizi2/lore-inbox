Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVJ3NLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVJ3NLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 08:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVJ3NLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 08:11:05 -0500
Received: from ns.isp.nsc.ru ([194.226.178.19]:1252 "EHLO ns.isp.nsc.ru")
	by vger.kernel.org with ESMTP id S1751240AbVJ3NLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 08:11:04 -0500
Subject: cpufreq driver + wrong cpu time
From: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 30 Oct 2005 19:11:24 +0600
Message-Id: <1130677884.3318.15.camel@m00>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to everyone.

I have written cpufreq_nForce4 kernel driver for  cpufreq subsystem.
It allows for CPU frequency changing by adjusting FSB speed, for nForce4
based motherboards. 
Works for single-cpu systems, as well as for SMP.
The problem is, after changing CPU(s) speed on SMP systems, programs
report wrong cpu time (wall time is OK). 
What would be the best way to fix this, and shouldn't this be done by
the cpufreq subsystem, rather than by hardware driver? 

P.S
Please include me in the CC explicitly!

Best Regards,
Alexander Shaposhnikov
   

