Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbUAJSMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUAJSMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:12:17 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:48591 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S265278AbUAJSMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:12:15 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None that appears to be detectable by casual observers
To: John Lash <jlash@speakeasy.net>
Subject: Re: Q re /proc/bus/i2c
Date: Sat, 10 Jan 2004 13:12:09 -0500
User-Agent: KMail/1.5.1
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401100117.42252.gene.heskett@verizon.net> <200401100754.47752.gene.heskett@verizon.net> <20040110095911.7b99d40c.jlash@speakeasy.net>
In-Reply-To: <20040110095911.7b99d40c.jlash@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101312.09624.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.61.108] at Sat, 10 Jan 2004 12:12:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 10:59, John Lash wrote:
>In a 2.6.x kernel, the sensors information is kept in sysfs. I
> haven't actually tried installing lmsensors on my 2.6 system, but
> if I look in: /sys/bus/i2c/devices/0-002d/
>I can see files for all of the sensors on my system.

I do not have an 0-002d subdir in /sys/bus/i2c/devices
Here is what I do have:
-------------------------
[root@coyote devices]# tree
.
|-- 0-0050 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0050
|-- 0-0051 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0051
|-- 0-0052 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0052
|-- 0-0053 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0053
|-- 0-0054 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0054
|-- 0-0055 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0055
|-- 0-0056 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0056
|-- 0-0057 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0057
|-- 0-0061 -> ../../../devices/pci0000:00/0000:00:09.0/i2c-0/0-0061
|-- 1-0050 -> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0050
`-- 1-0051 -> ../../../devices/pci0000:00/0000:00:11.0/i2c-1/1-0051

11 directories, 0 files
--------------------------
In checking the 'name' string in these, they are all related to either 
the pair of 256Mb dimms, or the bt878 card and its tuner.

tvtime, FWIW, works just fine except for a somewhat low audio level.

>Check below in your last mail where it is complaining about
> "Algorithm: Unavailable from sysfs".
>
>--john
[...my older message for brevity]
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

