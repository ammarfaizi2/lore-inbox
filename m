Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKUB7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKUB7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVKUB7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:59:25 -0500
Received: from mail.tmr.com ([64.65.253.246]:7040 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932174AbVKUB7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:59:25 -0500
Message-ID: <43812C6F.1000401@tmr.com>
Date: Sun, 20 Nov 2005 21:09:51 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz>
In-Reply-To: <20051118232019.GA2359@spitz.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>>Can you try some filesystem test while forcing disk spindowns via
>>>hdparm?
>>>
>>>It may be bug in laptop mode, or a bug in ide (or something
>>>related)... trying spindowns without laptopmode would be helpful.
>>>
>>>      
>>>
>>I don't know if it would be helpful, but I run several servers with 
>>multiple drives, usually 4-5, some of which are in RAID and some aren't, 
>>and they all spin down and restart without problems many times a day. 
>>The kernel is 2.6.14.? with one patch to get my unsupported VIA IDE working.
>>
>>My laptop also has a spindown (five min from memory) and I have yet to 
>>have a problem with it. Don't know if any of that is "spindowns without 
>>laptopmode" in a useful sense.
>>    
>>
>
>Unless you can also reproduce the failure... no, probably does not help
>much.
>  
>
No, that was really the point, even on multiple systems using spindown, 
I have no failures. I see four possible causes:
  1 - spindown
  2 - laptop mode
  3 - 1 + 2
  4 - bad hardware, kernel not at fault

Since I have a lot of (1) data I thought eliminating that as a cause by 
itself might be helpful.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

