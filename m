Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUAKJqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUAKJqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:46:23 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:58251 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265817AbUAKJqV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:46:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: no trace crash, running 2.6.1-mm1
Date: Sun, 11 Jan 2004 04:46:19 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401110446.19886.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.56.190] at Sun, 11 Jan 2004 03:46:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This crash was hard, and trashed the /usr partition.  Thats not so 
bad, but it took about 20 reboots to get it past fscking the 
/dev/hda8 (/usr) partition before I could get it back up.

No trace of the crash exists in the messages log, it quit logging 
about the time I shut the monitor off and went to bed, and when I 
found it totally unresponsive at 3:10, about 2.5 hours later.

However, getting past the e2fsck of /usr, aka /dev/hda8, was a bit 
frustrating as it would get to some arbitrary point, usually about 
halfway thru that 70Gb partition and get stuck in a loop outputting 
what I assume is debugging info, and finally ending in a kernel 
panic.

I took a picture of the screen at that point, but its a 3.2 mpixel 
camera so the .jpg file will be around 700k if anyone is interested 
in doing an autopsy on it.  I won't abuse the list with that big a 
file.

Also on the reboot, ksysguard cannot connect, but I've not lifted the 
hood on that one yet.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

