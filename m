Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbUBIVqc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 16:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUBIVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 16:46:32 -0500
Received: from smtp.mailix.net ([216.148.213.132]:42398 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263946AbUBIVqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 16:46:30 -0500
Date: Mon, 9 Feb 2004 22:46:22 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: alsa-devel@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
Message-ID: <20040209214622.GA1944@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	alsa-devel@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jaroslav Kysela <perex@suse.cz>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-SA-Exim-Mail-From: fork0@users.sourceforge.net
Subject: 2.6.3-rc1: intel8x0 broken
Content-Type: text/plain; charset=us-ascii
X-Spam-Report: *  0.5 RCVD_IN_NJABL_DIALUP RBL: NJABL: dialup sender did non-local SMTP
	*      [80.142.164.112 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_NJABL RBL: Received via a relay in dnsbl.njabl.org
	*      [80.142.164.112 listed in dnsbl.njabl.org]
	*  0.1 RCVD_IN_SORBS RBL: SORBS: sender is listed in SORBS
	*      [80.142.164.112 listed in dnsbl.sorbs.net]
	*  2.5 RCVD_IN_DYNABLOCK RBL: Sent directly from dynamic IP address
	*      [80.142.164.112 listed in dnsbl.sorbs.net]
X-SA-Exim-Version: 3.1 (built Thu Oct 23 13:26:47 PDT 2003)
X-SA-Exim-Scanned: Yes
X-uvscan-result: clean (1AqJKO-0004tL-OT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Gigabyte GA-I8IPE1000 Pro motherboard with a built-in 82801EB
(Intel Corp. 82801EB AC'97 Audio Controller).

The thing stopped produce any sound since Linus' last alsa update.
Reverting to the previous state of alsa driver works, of course.

Nothing in logs, no errors from programs. It is an SMT P4(ht), 1Gb, no
highmem.

Alsa-library is 1.0.2. I also tried to upgrade ac97 and intel8x0 code in
the kernel up to 1.0.2c (where it differed). Didn't change a thing.
(Strangely, there _are_ differences between 1.0.2c and the code in
kernel, even though pulling from linux-sound.bkbits.net/linux-sound does
no pulls anything).

I read the thread "intel8x0 has stopped working", started by James
Courtier-Dutton on alsa-devel, but can't figure out how to apply
anything of the discussion to my situation :)

