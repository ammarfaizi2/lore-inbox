Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272429AbRILSse>; Wed, 12 Sep 2001 14:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272431AbRILSsY>; Wed, 12 Sep 2001 14:48:24 -0400
Received: from 100m.mpr200-1.esr.lvcm.net ([24.234.0.80]:37139 "EHLO
	100m.mpr200-1.esr.lvcm.net") by vger.kernel.org with ESMTP
	id <S272429AbRILSsN>; Wed, 12 Sep 2001 14:48:13 -0400
Message-ID: <3B9FADFB.7000002@email.com>
Date: Wed, 12 Sep 2001 11:48:27 -0700
From: Tom Garland <tgarland@email.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010910
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch 2.4.9-pre4 kills mouse & keyboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To Whom?

The following are my efforts to report a problem with 
'Patch2.4.9-pre4' created by Kurt Garloff (K.Garloff@ping.de)
the email to him bounced, his was address obtained from DejaNews 
postings. He is not in the 'MAINTAINERS' list.

The problem was also posted on thefollowing news groups.
Xref: sn-us comp.os.linux.development.system:124031 
fa.linux.kernel:158958 comp.os.linux.x:181103

Thanks in advance - Tom

> Dear Kurt, the following is a report of a problem I submitted 

> to comp.os.linux.development.system,fa.linux.kernel,comp.os.linux.x
> and I thought a mail to you also via Pan 0.9.7. (I think that the 

> mail didn't make it to you). [:(]
> 
> I am sending you this email hoping to get a response/fix? Please
> submit your name to the kernel 'MAINTAINERS' list for linux.
> 
> I'll test any patches/changes you care to make.
> 
> Thank you in advance for your help.
> 
>> Path: sn-us!sn-xit-04!sn-post-01!supernews.com!corp.supernews.com!not-for-mail
>> From: "Tom Garland" <tgarland@void.email.com>
>> Newsgroups: comp.os.linux.development.system,fa.linux.kernel,comp.os.linux.x
>> Subject: Patch 2.4.9-pre4 kills mouse & keyboard
>> Followup-To: comp.os.linux.development.system,fa.linux.kernel
>> Date: Fri, 31 Aug 2001 10:57:15 -0700
>> Organization: Posted via Supernews, http://www.supernews.com
>> Message-ID: <tovjvqj2mjiaf9@corp.supernews.com>
>> User-Agent: Pan/0.9.7 (Unix)
>> Mime-Version: 1.0
>> Content-Type: text/plain; charset=ISO-8859-1
>> Content-Transfer-Encoding: 8bit
>> X-Complaints-To: newsabuse@supernews.com
>> Lines: 35
>> Xref: sn-us comp.os.linux.development.system:124031 fa.linux.kernel:158958 comp.os.linux.x:181103
>> 
>> Description: When using a KVM (keyboard, video, mouse) manual switch,
>> input from both the mouse and keyboard are lost after switching from one
>> system to another. Because of this both systems have to be reset to
>> recover. The change that affects me seems to be in
>> 'v2.4.8/linux/drivers/char/pc_keyb.c'. No changes to .config,  will send
>> if needed (PS/2 wheel mouse).
>> 
>> Prior to installing patch 2.4.9pre4 (using patch 2.4.9-pre3) on 2 systems
>> when switching between systems I would lose just the mouse wheel function
>> of switches 4 & 5 (wheel up and down). Switches 1, 2 and 3 worked fine as
>> did the keyboard. To recover from this situation all I have to do is start
>> a new  x-server desktop, either by closing the current desktop and doing
>> startx or starting a new desktop using the x-server (ctrl-alt-f2, logon,
>> startx -- :1 ). No reset/boot necessary.  [:-)] It seems to me that X does
>> some kind of mouse query or scan that activates it.
>> 
>> What does
>>       " - Kurt Garloff: make PS/2 mouse reconnect adjustable like 2.2.x"
>> in patch 2.4.9-pre4 mean? I can't find any documentation on 'mouse
>> reconnect'.
>> 
>> Why did this 'fix' kill my keyboard input? I need it to recover from the
>> mouse problem, like maybe having a mouse scan/restart function or
>> executable?
>> 
>> I seems to me that this a a step backwards, unless we can find a solution
>> other the having to buy an expensive electronic KVM switch with keep-alive 
>>      ^^ than ^^
>> circuits to prevent losing both the keyboard and mouse when switching
>> systems.  [:-(]
>> 
>> Thanks in advance for any help.
>> 
>> Remove void. in 'From:' for a valid reply address.
>> 
>> Tom Garland
>> 

-- 
-= Tom Garland =-

