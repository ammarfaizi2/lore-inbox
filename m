Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264621AbRFPNYW>; Sat, 16 Jun 2001 09:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbRFPNYM>; Sat, 16 Jun 2001 09:24:12 -0400
Received: from juicer35.bigpond.com ([139.134.6.87]:41430 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S264621AbRFPNYD>; Sat, 16 Jun 2001 09:24:03 -0400
Message-Id: <m15BG8K-001UIwC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        suganuma <suganuma@hpc.bs1.fc.nec.co.jp>,
        Anton Blanchard <antonb@au.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>
Subject: [ANNOUNCE] HotPlug CPU patch against 2.4.5
Date: Sat, 16 Jun 2001 23:29:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	http://sourceforge.net/projects/lhcs/

	Version 0.3 (untested) of the HotPlug CPU Patch is out, with
ia64 and x86 support.  Bringing CPUs down and up is as simple as:

	# Down...
	echo 0 > /proc/sys/cpu/1
	# Up...
	echo 1 > /proc/sys/cpu/1

	Apologies for the slow release, and *huge* kudos to the people
who did the real work for this release:

	Kimio Suganuma (ia64)
	Jason McMullan (x86)

Thanks!
Rusty.
--
Premature optmztion is rt of all evl. --DK
