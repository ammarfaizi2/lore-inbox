Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbUAJU4H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUAJU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:56:07 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:19596 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S265338AbUAJU4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:56:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 15:56:01 -0500
User-Agent: KMail/1.5.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <200401100754.47752.gene.heskett@verizon.net> <3FFFE8E4.8080004@clanhk.org>
In-Reply-To: <3FFFE8E4.8080004@clanhk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101556.01736.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 14:56:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 06:58, J. Ryan Earl wrote:
>Gene Heskett wrote:
>>On Friday 09 January 2004 20:47, J. Ryan Earl wrote:
>>
>>
>>I've also got a bttv card, whose init seems to be done quite early
>> in the bootup, and that requires I have i2c-dev in the kernel.  So
>> I might as well put it all in, the current situation.  All in, or
>> all out, it doesn't work.  A run of sensors right now, returns
>> this:
>
>A couple questions:
>
>1) Have you installed the lm-sensors package?

By hand, make user_install did not in fact overwrite any of the older 
sensors stuff, so I did it with mc.

>2) What kernel version?

2.6.1-mm1

>Even with 2.6, you need to install the lm-sensors package, but not
> the i2c package as the kernel already has everything needed in it. 
> The lm-sensors packages contains drivers for all the sensor chips. 
> After you get lm-sensors installed on your current kernel, run
> sensors-detect to get the proper modules loaded for your hardware.
>
>-ryan

Reread the README in lm_sensors-2.8.2.  I've followed that, except 
that a make user_install apparently only goes thru the motions 
without reporting any errors.

Been there, done that, a dozen times maybe?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

