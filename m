Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129483AbQKNRPP>; Tue, 14 Nov 2000 12:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQKNRPG>; Tue, 14 Nov 2000 12:15:06 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:41735 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129092AbQKNROv>; Tue, 14 Nov 2000 12:14:51 -0500
Date: Tue, 14 Nov 2000 10:44:50 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: linux-kernel@vger.kernel.org
Subject: Laggin Mouse on IBM Thinkpad 240
Message-ID: <20001114104450.D13719@ganymede.isdn.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Whenever my IBM Thinkpad 240 (running 2.2.17 with apmd) goes into
``sleep'' mode and then wakes up, the mouse and typing tend to lag quite
a bit. So much so that it becomes very hard to get anything done on the
machine. This happens mostly when it's in battery mode (not plugged in)
but occaisionally occurs when it's plugged in.

The .config file options I have turned on for power management are:

CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_IGNORE_MULTIPLE_SUSPEND=y
CONFIG_APM_IGNORE_SUSPEND_BOUNCE=y
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOWS_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

I've tried the 2.4.0test* kernels with similar results...

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
