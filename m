Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTKOJxh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTKOJxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:53:37 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:16907 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261595AbTKOJxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:53:36 -0500
Message-ID: <3FB5F79F.703@dcrdev.demon.co.uk>
Date: Sat, 15 Nov 2003 09:53:35 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hard lock on 2.6-test9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chipset is E7505 with dual Xeons.

Under X, I can provoke a lock just by waggling the mouse.  I've had the 
machine connected up to a serial console with nmi_watchdog=1 and, when 
the machine dies, nothing is printed on the console (I guess that makes 
it *very* bad :( ).

Booting with "noapic" helps stability considerably (though I have had 
one lockup with even that this morning).  I've also tried disabling AGP 
support in-kernel and that makes no difference.

Strangely, 2.4 is considerably more stable (without "noapic") - anybody 
have any idea what's going on or what to look at next (I'm happy to roll 
my sleeves up and stare at code - just need some pointers)?

If you'd like more details, let me know and I'll post them.

Many thanks,

Dan.

P.S.  There appear to have been other recent discussions on this topic 
with complaints of IDE (I have an MPT/Fusion SCSI setup) and ethernet 
load being enough to cause the hard lock.


