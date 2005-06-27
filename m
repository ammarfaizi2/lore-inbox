Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVF0KhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVF0KhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVF0KhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:37:07 -0400
Received: from gate.corvil.net ([213.94.219.177]:31756 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261431AbVF0KhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:37:01 -0400
Message-ID: <42BFD6AB.2080501@draigBrady.com>
Date: Mon, 27 Jun 2005 11:36:27 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
CC: Paul Sladen <thinkpad@paul.sladen.org>, linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, borislav@users.sourceforge.net,
       "'Pavel Machek'" <pavel@ucw.cz>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <42BD9797.4030009@linuxwireless.org>
In-Reply-To: <42BD9797.4030009@linuxwireless.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:
> Paul Sladen wrote:
> 
>> On Thu, 23 Jun 2005, Lee Revell wrote:
>>  
>>
>>> Yup, it's just doing port IO.  Get a kernel debugger for windows like
>>> softice and this will be trivial to RE.
>>> READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
>>>   
>>
>>
>> There are 3 ports involved.  The 0xed "non-existant delay port" and a 
>> pair
>> of ports that are through the Super-I/O / IDE.  They are used in a
>> index+value setup similar to reading/writing the AT keyboard controller.

Note the winbond docs are incomplete for the W83627HF at least.
I needed to download the reference for the W83697HF to complete
the picture for when I was writing:
http://lxr.linux.no/source/drivers/char/watchdog/w83627hf_wdt.c

Give us a shout if you need any docs/programming help.

-- 
Pádraig Brady - http://www.pixelbeat.org
--
