Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbUL2Dfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbUL2Dfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 22:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbUL2Dfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 22:35:42 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:60623 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261182AbUL2Dfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 22:35:37 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: samba is broken for 2.6.10
Date: Tue, 28 Dec 2004 22:35:35 -0500
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412282235.35175.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.45.252] at Tue, 28 Dec 2004 21:35:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

Specifically, I can smbmount AND smbumount a share on another machine 
for boots up to and including 2.6.10-rc3, what I'm running now.

I cannot smbumount (or umount) that same external share when running 
2.6.10-rc3-mm1-VO.33-04 *or* 2.6.10.  The unmount command *thinks* 
the share is busy when all other paths have already been closed.  
This points the finger toward something in the -rc3-mm1 patch 
according to my SWAG.

I think this may be connected to my amdump failures where amandad 
turns into a zombie at some point in the estimate phase an 
uncomfortably large percentage of the time.

But I don't know how, AFAIK in my configs for amanda, it is using its 
own sockets and not anything from samba.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
