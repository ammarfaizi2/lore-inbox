Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVAQERC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVAQERC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 23:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVAQERC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 23:17:02 -0500
Received: from mail.tmr.com ([216.238.38.203]:26322 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262692AbVAQEQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 23:16:57 -0500
Message-ID: <41EB3F80.5050400@tmr.com>
Date: Sun, 16 Jan 2005 23:30:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Steffl <steffl@bigfoot.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SATA disk dead? ATA: abnormal status 0x59 on port 0xE407
References: <1105830698.15835.16.camel@localhost.localdomain><1105830698.15835.16.camel@localhost.localdomain> <41E9D28F.8010109@bigfoot.com>
In-Reply-To: <41E9D28F.8010109@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:
> Alan Cox wrote:
> 
>> On Sad, 2005-01-15 at 20:25, Erik Steffl wrote:
>>
>>>   I got these errors when accessing SATA disk (via scsi):
>>>
>>> Jan 15 11:56:50 jojda kernel: ata2: command 0x25 timeout, stat 0x59 
>>> host_stat 0x21
>>> Jan 15 11:56:50 jojda kernel: ata2: status=0x59 { DriveReady 
>>> SeekComplete DataRequest Error }
>>> Jan 15 11:56:50 jojda kernel: ata2: error=0x40 { UncorrectableError }
>>
>>
>>
>> Bad sector - the disk has lost the data on some blocks. Thats a physical
>> disk failure.
> 
> 
>   what's somewhat weird is that the disk _seemed_ OK (i.e. no errors 
> that I would notice, nothing in the syslog) and then suddenly the disk 
> does not respond at all, I tried dd_rescue and it ran for hours (more 
> than a day) and it rescued absolutely nothing. Is it possible that the 
> disk surface is OK but the electronics went bad? Is there anything that 
> can be done if that's the case? (I have another disk, same model).

You probably void your waranty on both drives if you swap the control 
board, it may require special tools you don't have, and I have done it 
in the past. Can you get to the point where it fails and cool it with a 
shot of freon (or whatever is politically correct these days)? May be 
thermal, in which case you run it until you back it up, then waranty it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
