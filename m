Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbULQH2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbULQH2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbULQH2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:28:18 -0500
Received: from mail.outpost24.com ([212.214.12.146]:18115 "EHLO
	klippan.outpost24.com") by vger.kernel.org with ESMTP
	id S262760AbULQH2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:28:11 -0500
Message-ID: <41C28A76.4080905@outpost24.com>
Date: Fri, 17 Dec 2004 08:27:50 +0100
From: David Jacoby <dj@outpost24.com>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
References: <200412151254.37612@WOLK><200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com> <41C211E3.8040601@tmr.com>
In-Reply-To: <41C211E3.8040601@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> David Jacoby wrote:
>
>> Marc-Christian Petersen wrote:
>>
>>> On Wednesday 15 December 2004 12:49, David Jacoby wrote:
>>>
>>>  
>>>
>>>> Anyone else tried to apply this patch? The patch does work but not
>>>> properly.
>>>> I guess the machie is secure against the DoS attack but after i
>>>> installed the patch
>>>> i cant use SSH.When i tryed to SSH i didnt get any password prompt.
>>>> user@autopsia:~$ ssh user@192.168.0.1
>>>> Permission denied, please try again.
>>>> Permission denied, please try again.
>>>> Permission denied (publickey,password,keyboard-interactive).
>>>> The patch will crash SSH :|
>>>>   
>>>
>>>
>>>
>>> without looking at the patch, I think this isn't the causer of the 
>>> patch at all.
>>>
>>> ciao, Marc
>>>
>>>  
>>>
>> Well it is, i booted on the old kernel and SSH worked perfect and 
>> then on the new kernel with the patch i cant SSH, i dont even
>> get an password prompt. I tried to ssh to more than one host aswell, 
>> i also removed the key in .known_hosts but it still doesnt work.
>
>
> Are you claiming that the unpatched 2.6 kernel works and the patched 
> didn't? Or that 2.6 doesn't work right in general on your system 
> because of configuration issues? Unless the same 2.6 kernel works 
> without the patch how can you even tell what is failing?
>
Well im sorry if i caused some mess ;), but it actually seems that the 
patch worked. I have no idea what when wrong the first time but
after further testing it worked. I would say that the problem was behind 
the keyboard and not in the patch.

Thanx for all your replies and that you tried to help but it seems that 
the patch is fine ;)

-- 
Outpost24 AB

David Jacoby
Research & Development

Office: +46-455-612310
Mobile: +46-455-612311
(www.outpost24.com) (dj@outpost24.com) 

