Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUBECUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBECUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:20:16 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:14322 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265111AbUBECUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:20:12 -0500
From: Walt Nelson <wnelsonjr@comcast.net>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: psmouse.c, throwing 3 bytes away
Date: Wed, 4 Feb 2004 18:20:39 -0800
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402041820.39742.wnelsonjr@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mouse has been acting wired occationally, not all the time. I receive the 
following error in the syslog. This has been happening since 2.6.2-RC3. I am 
currently using 2.6.2. Are these related?

Feb  4 13:56:02 gumby kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 
lost synchronization, throwing 3 bytes away.

The following occurs when starting KDE/X.
Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set 2, 
code 0x7a on isa0060/serio0).
Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't 
access hardware directly.
Feb  4 18:05:11 gumby kernel: atkbd.c: Unknown key released (translated set 2, 
code 0x7a on isa0060/serio0).
Feb  4 18:05:11 gumby kernel: atkbd.c: This is an XFree86 bug. It shouldn't 
access hardware directly.

Thanks in advance

Walt
