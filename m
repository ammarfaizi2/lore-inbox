Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVGGGsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVGGGsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVGGGqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:46:06 -0400
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:7834 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261189AbVGGGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:45:06 -0400
From: Sheo Shanker Prasad <ssp@creativeresearch.org>
Organization: Creative Research Enterprises
To: linux-kernel@vger.kernel.org
Subject: Disturbing wide variation in execution time
Date: Wed, 6 Jul 2005 23:44:53 -0700
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200507062344.53615.ssp@creativeresearch.org>
X-ELNK-Trace: c9e54813b5d7ed8a1e28108c03118538416dc04816f3191cc806d4903c0e600da0ddfb054188493450ceeb96deec3bed350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.4.45.120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will appreciate your help in eliminating a disturbing wide variation (by a 
factors of 2 to 2.5) in the execution time of a test (execution benchmark) 
program under identical conditions even when the machine is freshly started 
(rebooted) and no other user program is running (not even e-mail or Internet 
browser).

I have a dual Opteron 250 (2.4 GHz) running SuSE 9.3 Pro & Linux version 
2.6.11.4-21.7-smp (geeko@buildhost) (gcc version 3.3.5 20050117 (prerelease) 
(SUSE Linux)) #1 SMP Thu Jun 2 14:23:14 UTC 2005. The motherboard is Tyan 
Thunder K8W (S2885 ANRF) with AMI BIOS

The machine has 4GB of PC3200 DDR RAM, two dimms on each CPU.

The original machine bought from a vendor about 6 months ago. At that time it 
was running SuSE 9.1 Pro and the execution time for the same test program was 
consistently the same (around 2m 37s +/- a few %). Then the mother board 
failed and the machine went totally dead. The vendor then replaced the failed 
motherboard with a new Tyan Thunder K8W and installed the SuSE 9.3. I am not 
sure whether or not the AMI BIOS was also replaced.

When the repaired machine was started, I began to notice the disturbing wide 
variation and the frequect significant slow down of the machine as exhibited 
by the factor of 2 to 2.5 increased execution time of the test program as 
described above.  Sometimes it would be quite fast (executing at the original 
2m 40s) and sometime a factor of 2.5 slow, and sometimes with speed in 
between.

I have already done these tests. I have tested the memory using both 
memtest86+ version 1.6 and memtest86-3.2. In both tests done over 3 cycles NO 
memory error was reported. I also ran Linux version of BYTE Bench mark for 
memory, floating point and integer indices. These tests matched test reported 
by others for their Opteron 250. 

Nevertheless, I have this wide and random variation in the execution time of 
given program under identical conditions. Guided by the comments I 
received from suse-amd64 user mailing list and the advises posted on LKML.ORG 
(this list), I tried booting with the option "mem=3000M" (significantly less 
than 4000M). That does not help either.

I am now perplexed as to why the machine is behaving with so unpredictable 
speeds varying by  factors of 2 to 2.5. What could the the cause and how can 
I get rid of it and make the machine reliable and efficient? (Also, when I 
boot with mem=3000M, then does that mean that the remainingg memory is wasted? 
What is the significance of putting that limit on the memory?)

Your help will be greatly appreciated.

Best regards.

Sheo
(Sheo S. Prasad)
Creative Research Enterprises
6354 Camino del Lago
Pleasanton, CA 94566, USA
Voice Phone: (+1) 925 426-9341
Fax   Phone: (+1) 925 426-9417
e-mail: ssp@CreativeResearch.org

