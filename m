Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbULPWy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbULPWy4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbULPWyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:54:31 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:3201 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262056AbULPWwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:52:14 -0500
Message-ID: <41C211E3.8040601@tmr.com>
Date: Thu, 16 Dec 2004 17:53:23 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jacoby <dj@outpost24.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
References: <200412151254.37612@WOLK><200412151254.37612@WOLK> <41C0268B.2030708@outpost24.com>
In-Reply-To: <41C0268B.2030708@outpost24.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Jacoby wrote:
> Marc-Christian Petersen wrote:
> 
>> On Wednesday 15 December 2004 12:49, David Jacoby wrote:
>>
>>  
>>
>>> Anyone else tried to apply this patch? The patch does work but not
>>> properly.
>>> I guess the machie is secure against the DoS attack but after i
>>> installed the patch
>>> i cant use SSH.When i tryed to SSH i didnt get any password prompt.
>>> user@autopsia:~$ ssh user@192.168.0.1
>>> Permission denied, please try again.
>>> Permission denied, please try again.
>>> Permission denied (publickey,password,keyboard-interactive).
>>> The patch will crash SSH :|
>>>   
>>
>>
>> without looking at the patch, I think this isn't the causer of the 
>> patch at all.
>>
>> ciao, Marc
>>
>>  
>>
> Well it is, i booted on the old kernel and SSH worked perfect and then 
> on the new kernel with the patch i cant SSH, i dont even
> get an password prompt. I tried to ssh to more than one host aswell, i 
> also removed the key in .known_hosts but it still doesnt work.

Are you claiming that the unpatched 2.6 kernel works and the patched 
didn't? Or that 2.6 doesn't work right in general on your system because 
of configuration issues? Unless the same 2.6 kernel works without the 
patch how can you even tell what is failing?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
