Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274892AbTHPR5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 13:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274897AbTHPR5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 13:57:47 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:62205 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP id S274892AbTHPR5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 13:57:46 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: increased verbosity in dmesg
Date: Sat, 16 Aug 2003 13:57:45 -0400
User-Agent: KMail/1.5.1
Cc: <felipe_alfaro@linuxmail.org>, <linux-kernel@vger.kernel.org>
References: <200308160438.59489.gene.heskett@verizon.net> <200308161136.01133.gene.heskett@verizon.net> <32980.4.4.25.4.1061055714.squirrel@www.osdl.org>
In-Reply-To: <32980.4.4.25.4.1061055714.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308161357.45381.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [151.205.12.137] at Sat, 16 Aug 2003 12:57:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 13:41, Randy.Dunlap wrote:
>> Which says that a setting of 15 would get 32k then.
>> I take it this (for an i386 system) is the correct file to edit?
>>
>> kernel/ikconfig.h:CONFIG_LOG_BUF_SHIFT=14 \n\
>> Mmmm, that says do not edit, auto-generated, so how about this
>> one?
>>
>> include/config/log/buf/shift.h
>>
>> which contains only that single line.  Its now 15 & we'll see.
>
>No, you don't edit either of those files.
>You use 'make *config' or you edit .config and then
>run make oldconfig.
>
>~Randy

Humm, I didn't make an oldconfig, but I did mess around with 
menuconfig before I built it.  Took some gingerbread out of it.  
Enough that my grub line 'vga=791' gave me a blank screen, but 
apparently did boot.  I rebooted to a different kernel, fixed that 
line in grub.conf, and I'm running on it right now.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

