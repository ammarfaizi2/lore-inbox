Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVDFXVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVDFXVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 19:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVDFXVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 19:21:22 -0400
Received: from outbound04.telus.net ([199.185.220.223]:30102 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S262351AbVDFXVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 19:21:15 -0400
Subject: Re: Linux 2.6.12-rc2
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 17:20:52 -0600
Message-Id: <1112829652.8941.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK.  So far so good.  I can get 2.6.12-rc2 to run fine if:
1. I do not in any way attempt to *ahem* overclock the box.
--if I do, I get really ugly race errors flying around from just about
everywhere (pick a device at random, have it trip, and the scheduler
tripping right behind it).
2. I do not attempt in any way to run any sort of Nvidia (non-GPL)
driver.  It fights with SBP2 (in a lot of different ways, first the
drivers want to kill off Firewire drives (one detected, the other not,
then on next boot, the reverse...), and also, when using GLX apps (and
trying to write to an SBP2 connected device, they clash (and fight and
the kernel doesn't die but gets bogged in errors...)
....and with the notes above, as I say, so far, so good.  I am
attempting to hammer away at every device I have on the box (scanner,
printer, video (only GPL Nvidia), audio, cd, dvd, tv tuner etc.) so far,
so good.
Bob
-- 
Bob Gill <gillb4@telusplanet.net>

