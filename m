Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757642AbWKYFZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbWKYFZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 00:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbWKYFZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 00:25:29 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:19394 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S1757642AbWKYFZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 00:25:28 -0500
Message-ID: <4567D4C7.10505@sandall.us>
Date: Fri, 24 Nov 2006 21:29:43 -0800
From: Eric Sandall <eric@sandall.us>
Organization: Source Mage GNU/Linux
User-Agent: Mail/News 1.5.0.8 (X11/20061121)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend broken in 2.6.18.1
References: <45144C61.5020104@sandall.us> <20060923110954.GD20778@elf.ucw.cz> <453406F0.5020803@sandall.us>
In-Reply-To: <453406F0.5020803@sandall.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandall wrote:
> Pavel Machek wrote:
>> Hi!
>>
>>> After updating from 2.6.17.13 to 2.6.18 (using `make oldconfig`),
>>> suspend no longer suspends my laptop (Dell Inspiron 5100).
>>>
>>> # s2ram -f
>>> Switching from vt7 to vt1
>>> s2ram_do: Invalid argument
>>> switching back to vt7
>>>
>>> The screen blanks, but then comes back up after a few seconds. This
>>> happens both with and without X running.
>>>
>>> I've attached the output of `lspci -vvv` and my
>>> /usr/src/linux-2.6.18/.config for more information. Please let me know
>>> if there are any patches to try or if more information is required.
>> Relevant part of dmesg after failed attempt is neccessary... and you
>> can probably read it yourself and figure what is wrong. I'd guess some
>> device just failed to suspend... rmmod it.
> 
> (This is now with 2.6.18.1)
<snip>

Seems to be working fine in 2.6.18.3, thanks!

-sandalle

-- 
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
