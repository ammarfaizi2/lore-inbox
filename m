Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135684AbRD2HOo>; Sun, 29 Apr 2001 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135687AbRD2HOe>; Sun, 29 Apr 2001 03:14:34 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:27076 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135684AbRD2HO3>; Sun, 29 Apr 2001 03:14:29 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 29 Apr 2001 00:14:09 -0700
Message-Id: <200104290714.AAA03758@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org, mhaque@haque.net,
        peter.osterlund@mailbox.swipnet.se
Subject: Re: 2.4.4 sluggish under fork load
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.

	I have reproduced this on a uniprocessor machine and determined
that it is a bash bug.  I will submit a bash bug report and sample
patch that fixes the problem (but may be incorrect in other ways), and
will cc it to linux-kernel.  Look for the subject "Patch(?): bash-2.05/jobs.c
loses interrupts."

	I have not yet investigated the other report of "sluggish" behavior.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
