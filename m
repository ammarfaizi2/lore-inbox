Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbULKW0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbULKW0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 17:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbULKW0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 17:26:20 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:18876 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262028AbULKW0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 17:26:18 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Improved console UTF-8 support for the Linux kernel?
Date: Sat, 11 Dec 2004 17:26:16 -0500
User-Agent: KMail/1.7
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David =?iso-8859-1?q?G=F3mez?= <david@pleyades.net>,
       Simos Xenitellis <simos74@gmx.net>
References: <1102784797.4410.8.camel@kl> <20041211212533.GA13739@fargo> <Pine.LNX.4.53.0412112234550.2492@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0412112234550.2492@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412111726.17242.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.42.94] at Sat, 11 Dec 2004 16:26:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 December 2004 16:39, Jan Engelhardt wrote:
>>Indeed is weird. Are you sure you keyboard is generating an UTF-8
>>enconded "ö"? Just check it with echo:
>>
>>$ echo -n ö | od -t x1
>>
>>0000000 c3 b6
>>0000002
>
>Yes it does generate 0xC3B6 (otherwise it would show up as garbage,
> because it would not be utf8-compliant if it only output 0xF6)

Which is exactly (0xF6) what I'm getting.  Kernel version
2.6.10-rc2-mm3-V0.7.32-18

As an american, I've often wondered how to go about getting those
accented characters out of a std american keyboard.  I used to be
able to get all those accented and other stuffs out of my amiga's
keyboard, stuff like the Beta sign and so on.  No can do now, and I
miss it.

[...]

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

