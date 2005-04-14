Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVDNAm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVDNAm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVDNAm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:42:59 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57772 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261408AbVDNAm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:42:58 -0400
Message-ID: <425DBC76.60804@labs.fujitsu.com>
Date: Thu, 14 Apr 2005 09:42:30 +0900
From: tsuchiya yoshihiro <yt@labs.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: yt@labs.fujitsu.com
Subject: SLEEP_ON_BKLCHECK
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In Fedora Core3, interruptible_sleep_on() checks if the system is
lock_kernel()'ed
by SLEEP_ON_BKLCHECK. Same thing is done in RedHatEL4.
Also I found a patch including SLEEP_ON_BKLCHECK was posted before,
but is not included in 2.6.11.
Why SLEEP_ON_BKLCHECK checks lock_kernel ? Lock_kernel shoud be held
during sleep_on_timeout? And I also wonder why 2.6.11 does not check it.

Thank you,
Please CC me because I am not subscribing this list.
Yoshi Tsuchiya
