Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUASDfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUASDfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 22:35:38 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:48390 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261872AbUASDfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 22:35:37 -0500
Date: Mon, 19 Jan 2004 14:05:27 +1030
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: linux-kernel@vger.kernel.org
Subject: TG3: very high CPU usage
Message-ID: <20040119033527.GA11493@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

Has the TG3 driver been well tested with the AC9100 and compatible gigabit NIC chipsets?

iperf, between a 2.6.0 box and a WinXP box (both running Netgear GA302Ts with the AC9100), shows max throughput of 35MB/sec.

However, when using Apache or any FTP client/daemon, the TG3 driver appears to be VERY slow maxing out CPU usage at 100% while only transfering at around 12MB/sec.
This applies for both incoming or outgoing data.

2.6.1 behaves worse, using 100% CPU usage to maintain approx 9MB/sec rates.

Ive tried other NICs, etc and confirmed that it is a problem with the TG3 driver.

Is this a known problem?

Thanks,
 Mark Williams.
