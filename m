Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136573AbREAEwc>; Tue, 1 May 2001 00:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136570AbREAEwW>; Tue, 1 May 2001 00:52:22 -0400
Received: from sync.nyct.net ([216.44.109.250]:16134 "HELO sync.nyct.net")
	by vger.kernel.org with SMTP id <S136573AbREAEwL>;
	Tue, 1 May 2001 00:52:11 -0400
Date: Tue, 1 May 2001 00:52:37 -0400
From: Michael Bacarella <mbac@nyct.net>
To: linux-kernel@vger.kernel.org
Subject: Question about /proc/kmsg semantics..
Message-ID: <20010501005237.A2776@sync.nyct.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two pronged:

I've seen a couple of patches in the archives to make open()/close()
on /proc/kmsg do more than NOP. As of 2.4.4, klogd still needs to
run as root since access is checked on read() rather than once at
open(). I can't find the rationale as to why they're rejected.

Also, why is reading /proc/kmsg a privileged operation, yet dmesg
can happily print out the entire ring via (do_)syslog() ?

Thanks

-- 
Michael Bacarella <mbac@nyct.net>
Technical Staff / System Development,
New York Connect.Net, Ltd.
