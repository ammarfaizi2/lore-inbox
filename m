Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULBEFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULBEFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbULBEFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:05:30 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:5829 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S261515AbULBEFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:05:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.10-rc2-mm3-V0.7.31-19
Date: Wed, 1 Dec 2004 23:05:26 -0500
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412012305.27009.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.46.7] at Wed, 1 Dec 2004 22:05:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Imgo;

I just built -19 and rebooted to it, and got this when I did
the startx:

Dec  1 22:44:11 coyote kernel: Linux agpgart interface v0.100 (c) Dave Jones
Dec  1 22:44:11 coyote kernel: [drm] Initialized drm 1.0.0 20040925
Dec  1 22:44:11 coyote kernel: [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 SE]
Dec  1 22:44:11 coyote kernel: ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
Dec  1 22:44:11 coyote kernel: ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 19 (level, high) -> IRQ 19
Dec  1 22:44:11 coyote kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
Dec  1 22:44:11 coyote kernel: [drm:drm_unlock] *ERROR* Process 3093 using kernel context 0

The drm module is loaded and apparently running.  glxgears runs, but
slow (300fps) as I may have some of the ati special stuff installed yet.

In terms of the overall usefullness, it almost going backwards in one area.

Kmail, when it fires off spamassassin, virtually locks up the composer,
ignoreing keyboard input as in showing it on the screen for as much as
30 seconds at a time.  Back at about -7 or -9 I had noted that the
cfq scheduler seemed to be exerting enough control over that that
the machine was still useable while a mail fetch was being done in
the background.  By -13 the lags were back to noticable and by -15
they were in full force as if I was running the anticipatory
scheduler, which I'm not.  This is now -19 and I'm waiting for the router
lights to tell me a mail fetch in in progress..  Ahh and its doing it again,
possibly not so bad, or there weren't any new messages.

Has there been any changes in that area or is this my imagination?


-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
