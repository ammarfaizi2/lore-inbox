Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUBWXA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 18:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUBWW7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:59:48 -0500
Received: from mail.convergence.de ([212.84.236.4]:42626 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262072AbUBWW6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:58:10 -0500
Message-ID: <403A8575.20900@convergence.de>
Date: Mon, 23 Feb 2004 23:57:57 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: torvalds@osdl.org, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] Update the DVB subsystem docs
References: <10775702813893@convergence.de> <Pine.LNX.4.53.0402231708440.4872@chaos>
In-Reply-To: <Pine.LNX.4.53.0402231708440.4872@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

On 02/23/04 23:23, Richard B. Johnson wrote:
> On Mon, 23 Feb 2004, Michael Hunold wrote:

>>+   The  Windows  drivers  for the Avermedia DVB-T can be obtained
>>+   from: http://babyurl.com/H3U970 and you can get an application
>>+   to extract the firmware from:
>>+   http://www.kyz.uklinux.net/cabextract.php.
>>+     _________________________________________________________
> 
> 
> Truly bizarre, weird........

DVB under Linux is sometimes cruel. Newer devices require firmware which 
cannot be legally distributed.

So these curde workarounds are necessary, unfortunately.


>>+   The  default  Linux  filesystem  location for this firmware is
>>+   /usr/lib/hotplug/firmware/sc_main.mc .

> What does this have to do with the kernel? Isn't this for some
> utility that starts Aver/TV? Surely the kernel doesn't read files.

The description said, that the file is also a nice introduction to DVB 
in general (with a close look to the avermedia cards), so this 
information wasn't stripped.

>> 		extracted from the Windows driver (Sc_main.mc).
>> - tda1004x: firmware is loaded from path specified in
>> 		DVB_TDA1004X_FIRMWARE_FILE kernel config
> 
> 
> WTF? The __kernel__ doesn't read files. User mode programs
> use the kernel to read files for them, on their behalf.

Please refer to my other mail to Christoph and Andrew. Some of the 
drivers uses historical cruft and we have a plan to overcome this.

> Cheers,
> Dick Johnson

CU
Michael.
