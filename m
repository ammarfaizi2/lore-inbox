Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbUL2CLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUL2CLW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 21:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbUL2CLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 21:11:21 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:25593 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261302AbUL2CLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 21:11:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Need hardware (chip) guru
Date: Tue, 28 Dec 2004 21:10:59 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412282110.59601.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.45.252] at Tue, 28 Dec 2004 20:11:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've read through the Intel pdf doc sheets on the Intel 82c55 about 4 
times now, looking for clues, but everything about the control 
register seems to be write only.  Their logic diagrams don't even 
acknowledge the existance of the control register.

Is there anyone here who can tell me how to read the current status of 
the ctl register in an 82C55?

The std inb(ctl_address, byte); is returning 0xff regardless of what I 
write with the corresponding outb statement <10 microseconds in front 
of the read.

I hate trying to program stuff this badly blinded by what appares to 
be a hardware limitation. ):>8

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
