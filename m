Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUKHE2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUKHE2x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 23:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUKHE2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 23:28:52 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:63450 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S261725AbUKHE2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 23:28:50 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: makeing a loadable module
Date: Sun, 7 Nov 2004 23:28:48 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411072328.48785.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [151.205.60.181] at Sun, 7 Nov 2004 22:28:49 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I found some code I can play with/hack/etc, in the form of a loadable 
module and some testing driver programs, in 'dpci8255.tar.gz'.

Unforch its for a slightly different card than the one I have, and 
once I've hacked the code to suit, I need to rebuild it.

So whats the gcc command line to make just a bare, loadable module for 
say a 2.4.25 kernel?   Obviously I'm missing something when it 
complains and quits, claiming there is no 'main' defined, which I 
don't think modules actually have one of those?

What I'm trying to do (hey, no big dummy jokes please :)

[root@coyote dist]# cc -o dpci8255.o dpci8255lib.c
/usr/lib/gcc-lib/i386-redhat-linux/3.3.3/../../../crt1.o(.text+0x18): 
In function `_start':
: undefined reference to `main'
collect2: ld returned 1 exit status

The gcc manpage isn't that helpfull and I've now read thru it twice.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
