Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUKDFLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUKDFLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 00:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbUKDFLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 00:11:06 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:27094 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262067AbUKDFLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 00:11:00 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: adding new device to pci bus
Date: Thu, 4 Nov 2004 00:10:59 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040010.59065.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.11.139] at Wed, 3 Nov 2004 23:11:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Some smallish non-progress on my CNC project.  I added the 
vendor/product description (00ff:0800) to drivers/pci/pci.ids and 
recompiled.

The data does make it into the self generated devlist.h file during 
the compile, but that appears to be as far as it gets.  On the reboot 
there is still no recognition of the cards presence in the logs, and 
the data I can extract from the /proc filesystem about the card is as 
limited as before.  It shows up on the pci bus as 00:10.0 and thats 
it.

This was using 2.6.10-rc1-bk10 as the test kernel, and on that old 
slow box, a 233mhz PII with 384 megs of ram, a kernel compile is a 
bit over 65 minutes!

I didn't ever expect that one change to be the magic twanger, but 
shouldn't I at least have seen something?

Whats the next step here since it appears I'm taking 1/64" steps?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
