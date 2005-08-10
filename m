Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbVHJTDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbVHJTDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 15:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVHJTDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 15:03:18 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:39950 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030201AbVHJTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 15:03:17 -0400
Message-ID: <42FA5094.4010702@tmr.com>
Date: Wed, 10 Aug 2005 15:08:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <20050730100658.GB1942@elf.ucw.cz>
In-Reply-To: <20050730100658.GB1942@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>I was finally able to get C3 state working. It seems that my BIOS is
>>leaving USB controllers in an active state(?). Without any USB drivers
>>loaded, C3 is not possible. With drivers loaded, but no device plugged
>>in C3 works fine. Kernel is 2.6.13-rc3-mm3 + acpi-sbs.
>>
>>With working C3 there are indeed differences:
>>
>>Voltage is 16.5 V
>>
>>HZ=100:  ~460 mA => 7.59 W
>>HZ=250:  ~468 mA => 7.72 W
>>HZ=1000: ~494 mA => 8.15 W
> 
> 
> 0.55W difference, wow. And that's 7% difference to overall system
> consumption.

But it's totally meaning less isn't it? Disable the USB, there goes the 
kb/mouse, turn off the LCD you can't see anything, spin down the disk, 
you can't do i/o, and run the CPU in idle so you can't DO anything.

At that point you might as well turn it off and save 100%.
