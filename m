Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUCCIYU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 03:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCCIYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 03:24:20 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:15506 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261532AbUCCIYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 03:24:19 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@ucw.cz>,
       George Anzinger <george@mvista.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
Subject: Code freeze on lite patches and schedule for submission into mainline kernel
Date: Wed, 3 Mar 2004 13:54:10 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403031354.10370.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have two sets of kgdb patches as of now: [core-lite, i386-lite, 8250] and 
[core, i386, ppc, x86_64, eth]. First set of kgdb patches (lite) is fairly 
clean. Let's consider it to be a candicate for submission to mainline kernel.

I am freezing the lite patches wrt. feature updates. Only bug-fixes and code 
cleanups will be allowed in lite patches. You can make any feature 
enhancements to second set of patches.

I propose following schedule for pushing kgdb lite into mainline kernel:
Take 1: 8th , Take 2: 15th, Take 3: 22nd, Take 4:29th. I'll download the 
kernel snapshot (http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/) on 
these dates and submit a single patch for possible acceptance into mainline 
kenrel and feedback from community. Hopefully we'll succeed by end of this 
month.

Please checkin any fixes or cleanups by end of this week. I plan to add some 
documentation to core-lite.patch this week (will send it for review in a 
separate email)

Comments/suggestions?
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

