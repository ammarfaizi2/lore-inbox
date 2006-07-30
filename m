Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWG3Mne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWG3Mne (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWG3Mne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:43:34 -0400
Received: from mail.tmr.com ([64.65.253.246]:26334 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932302AbWG3Mnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:43:33 -0400
Message-ID: <44CCACC9.7090702@tmr.com>
Date: Sun, 30 Jul 2006 08:57:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <44C42B92.40507@xfs.org> <20060728140059.GD4623@ucw.cz> <44CBB5BB.10009@tmr.com> <200607292319.31935.rjw@sisk.pl>
In-Reply-To: <200607292319.31935.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:

>On Saturday 29 July 2006 21:23, Bill Davidsen wrote:
>  
>
>>Pavel Machek wrote:
>>    
>>
>>>On Fri 28-07-06 01:22:49, Olivier Galibert wrote:
>>>      
>>>
>>>>On Thu, Jul 27, 2006 at 11:42:25PM +0200, Pavel Machek wrote:
>>>>        
>>>>
>>>>>So we have 1 submission for review in 11/2004 and 1 submission for -mm
>>>>>merge in 2006, right?
>>>>>          
>>>>>
>>>>Wrong.  I gave a list of dates at the beginning of the month, do you
>>>>think I threw dice to get them?
>>>>
>>>>And could you explain, as suspend maintainer for the linux kernel, how
>>>>come code submitted for the first time two years ago and with a much
>>>>better track record than the in-kernel one is still not in?
>>>>        
>>>>
>>>Because Nigel has too much of code to start with, and refuses to fix
>>>his design because it would invalidate all the stabilization work.
>>>      
>>>
>>Why should he invalidate his stabilization work, and what's in need of 
>>fixing? The suspend in the kernel is great, but suspend2 includes both 
>>suspend and working resume code as well.
>>    
>>
>>>Plus Nigel did not do very good job with submitting those patches.
>>>      
>>>
>>They apply, they work. What's not very good about that? Is this being 
>>blocked because of a spelling error, or did he mess up the indenting on 
>>"signed off by" or what? I realize you may have something other than the 
>>download version, but it's been years now.
>>
>>I would like to see the working suspend (suspend2) in the kernel, and 
>>users wanting to debug the resume stuff currently in the kernel could 
>>get it under EXPERIMENTAL or some such.
>>    
>>
>
>You probably don't realize how offensive this is.
>
>Actually some people have been working really hard to make the in-kernel
>code work and you could just respect that.
>  
>
By respect I take it you mean "don't call attention to the fact that it 
doesn't work for many people?"

>Now, please note the swsusp resume code works for me 100% of the time
>and I know of many people who use it without any problems.  Also I know of
>some people for whom suspend2 doesn't work.  Please take this into
>consideration.
>  
>
That's exactly the answer I've been getting for saveral years, "it works 
for me and my friends," and "try x.y.z release."

>Moreover, if the swsusp's resume doesn't work for you and suspend2's resume
>does, this probably means that suspend2 contains some driver fixes that
>haven't been submitted for merging.
>
That's been addressed by other people, but the suspend2 patch has been 
submitted multiple times, if there is some driver fix it certainly has 
been submitted, just not accepted.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

