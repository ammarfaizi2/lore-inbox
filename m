Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWHCEBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWHCEBq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWHCEBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:01:46 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:54920 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932313AbWHCEBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:01:46 -0400
Message-ID: <44D17525.2080705@comcast.net>
Date: Wed, 02 Aug 2006 23:01:41 -0500
From: Kyle Davenport <kdavenpo@comcast.net>
User-Agent: Mozilla/5.0 (X11; Microsoft Windows i686; en-US; IE6) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: system freeze on cdrom failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted on this before, and I'm confirming that the problem is still 
happening at 2.6.17.5.    Problem started with 2.6.15*.   Saw it again 
in 2.6.16.  If I reboot into 2.6.13, I still see some cdrom and/or scsi 
errors, but the system does not freeze.  This was from running grip on a 
music cd.  It also happens just reading most burned cd's or dvd's.  

Aug  1 23:23:00 quickest kernel: cdrom: dropping to single frame dma
Aug  1 23:23:02 quickest kernel: BUG: unable to handle kernel NULL 
pointer dereference at virtual address 0000000c

Problem drive is Toshiba DVD-ROM SD-M1401 (scsi).  I do not see any 
errors with the same media in a Yamaha CRW2100S (scsi burner).

Tyan Thunder K7X-Pro (S2469UNG)/ 2x2400 Athlon MP/ 1GB ram / 1TB disk / 
gcc 3.2

This is easily repeatable - please ask for more info!

Kyle
