Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTFDXfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbTFDXfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:35:07 -0400
Received: from devil.servak.biz ([209.124.81.2]:53229 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S264304AbTFDXfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:35:06 -0400
Subject: Another must-fix: sbp2 and firewire hard disk crashes hard.
From: Torrey Hoffman <thoffman@arnor.net>
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054770509.1198.79.camel@torrey.et.myrio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jun 2003 16:48:29 -0700
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This must be something about my particular hardware/software
configuration or more people would be reporting it.   

I will try to nail down the problem, but as soon as the SBP2 driver in
2.5.(recent) sees my firewire drive, either during kernel boot or later
if I turn on / plug in the drive, the system crashes and dumps a
seemingly endless stack trace.  It doesn't make it to the system log, so
I don't have much more than that yet.

Many more details available on request.  And more information coming
regardless.   

Unfortunately for me, 2.4 is extremely flaky for sbp2 as well. (sigh). 
Red Hat kernels oops a few seconds after the drive is plugged in, but
the system keeps running so I have some decoded oops for those at
least.  I'll try to get one from a stock 2.4.recent...

-- 
Torrey Hoffman <thoffman@arnor.net>

