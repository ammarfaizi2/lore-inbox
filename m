Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbUKDMl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUKDMl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUKDMlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:41:06 -0500
Received: from out001pub.verizon.net ([206.46.170.140]:13490 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262193AbUKDMjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:39:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 07:39:01 -0500
User-Agent: KMail/1.7
Cc: Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040657.10322.gene.heskett@verizon.net> <200411041412.42493.jk-lkml@sci.fi>
In-Reply-To: <200411041412.42493.jk-lkml@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040739.01699.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [151.205.11.139] at Thu, 4 Nov 2004 06:39:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 07:12, Jan Knutar wrote:
>On Thursday 04 November 2004 13:57, Gene Heskett wrote:
>> I'e had that turned on since forever Jan, but usually, when its
>> hung someplace, its well and truely hung, and hardware reset
>> button time.
>
>Are you saying that these zombies (or tasks stuck in state D) also
> make sysrq-T hang, and not list all tasks?

I thought I'd test it right now while the system is runnng normally, 
but I got only a beep from the console, so I went to 
Documentation/sysrq.txt to make sure I was doing it right, and it is 
_not_ working right now.  But it is compiled in according to a make 
xconfig, or a grep of the .config.

[root@coyote linux-2.6.10-rc1-bk13]# grep SYSRQ .config
CONFIG_MAGIC_SYSRQ=y

I get a couple of beeps from the console, but thats the limit of the 
response, and a tail -f on the log shows nothing.  I also logged into  
VC2, and tried it there, but that attempt didn't even get me a beep, 
several times.

The keyboard is a cheap ($24) M$ with a few extra buttons that don't 
do anything along the top.  And getting a bit creaky in its old age, 
a lot like me, but I'm about 68 years older than the keyboard :)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
