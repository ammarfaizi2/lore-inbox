Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUAJMyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 07:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbUAJMyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 07:54:52 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:55253 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S265152AbUAJMyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 07:54:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 07:54:47 -0500
User-Agent: KMail/1.5.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <3FFF59A0.2080503@clanhk.org>
In-Reply-To: <3FFF59A0.2080503@clanhk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100754.47752.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 06:54:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 20:47, J. Ryan Earl wrote:
>Gene Heskett wrote:
>>Greetings;
>>
>>I'm still trying to make sensors (and gkrellm) work when booted to
>> a 2.6.x kernel.
>>
>>The lm_sensors people say it should "just work", but so far no one
>> has acknowledged that it doesn't work here because I don't have an
>> "i2c" in my /proc/bus directory.  Browsing all the
>> sensors-detection stuff, in particular the bus detection script,
>> this thing is hard coded to look for /proc/bus/i2c by default, or
>> you can pass it an argument.
>>
>>I don't have a "/proc/bus/i2c".  Passing this script the
>> /sys/bus/i2c argument only gets an error return complaining that
>> its a directory.
>
>You've run the "sensors-detect" script and have all the proper
> modules loaded for your hardware?  You should be able to just run
> "sensors" to see if everything is working.
>
I've also got a bttv card, whose init seems to be done quite early in 
the bootup, and that requires I have i2c-dev in the kernel.  So I 
might as well put it all in, the current situation.  All in, or all 
out, it doesn't work.  A run of sensors right now, returns this:

[root@coyote lm_sensors-2.8.2]# sensors
eeprom-i2c-1-51
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-1-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-57
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-56
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-55
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-54
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-53
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-52
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-51
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

eeprom-i2c-0-50
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs
Memory type: Unavailable

Temic-i2c-0-61
Adapter: bt878 #0 [sw]
Algorithm: Unavailable from sysfs

Does this give a clue I'm too clueless to see?

>-ryan

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo.  Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

