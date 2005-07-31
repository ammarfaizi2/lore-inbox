Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVGaMmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVGaMmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 08:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGaMmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 08:42:52 -0400
Received: from 69.36.162.216.west-datacenter.net ([69.36.162.216]:22253 "EHLO
	schau.com") by vger.kernel.org with ESMTP id S261716AbVGaMmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 08:42:51 -0400
Message-ID: <42ECC771.2050607@schau.com>
Date: Sun, 31 Jul 2005 14:43:29 +0200
From: Brian Schau <brian@schau.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: James Cloos <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wireless Security Lock driver.
References: <42EB940E.5000008@schau.com> <20050730194215.GA9188@elf.ucw.cz> <42EBDEA9.60505@schau.com> <20050730203159.GB9418@elf.ucw.cz> <m3mzo3jriv.fsf@lugabout.cloos.reno.nv.us> <20050731095207.GJ9418@elf.ucw.cz>
In-Reply-To: <20050731095207.GJ9418@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the quirk is in the patch :-)

Pavel Machek wrote:
> Hi!
> 
> 
>>Pavel> Well, that is if you use /dev/psaux, right? Using event devices
>>Pavel> you should be able to access it from userland.
>>
>>Would /dev/input/mice not also be affected?
> 
> 
> Yes, /dev/input/mice == /dev/psaux.
> 
> 
>>Until X can hotplug input devices /dev/input/mice rather than evdev
>>will remain necessary in many cases for a reasonable user experience.
>>
>>So at least a quirk/whatever to keep that device from being included
>>in mice (and psaux) should be added.
> 
> 
> Yes... why not. But that should be close to one liner, right?
> 								Pavel
