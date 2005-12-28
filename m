Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVL1BJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVL1BJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbVL1BJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:09:24 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:34435 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932433AbVL1BJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:09:23 -0500
Message-ID: <43B1E5C1.4050908@bigpond.net.au>
Date: Wed, 28 Dec 2005 12:09:21 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
CC: Lee Revell <rlrevell@joe-job.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Steven Rostedt <rostedt@goodmis.org>, Jaco Kroon <jaco@kroon.co.za>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
References: <43AF7724.8090302@kroon.co.za>	 <200512261535.09307.s0348365@sms.ed.ac.uk>	 <1135619641.8293.50.camel@mindpipe>	 <200512262003.38552.s0348365@sms.ed.ac.uk> <1135630831.8293.89.camel@mindpipe> <43B1D6C6.30300@metaparadigm.com>
In-Reply-To: <43B1D6C6.30300@metaparadigm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 28 Dec 2005 01:09:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:
> Lee Revell wrote:
> 
> 
>>On Mon, 2005-12-26 at 20:03 +0000, Alistair John Strachan wrote:
>> 
>>
>>
>>>On Monday 26 December 2005 17:54, Lee Revell wrote:
>>>   
>>>
>>>
>>>>On Mon, 2005-12-26 at 15:35 +0000, Alistair John Strachan wrote:
>>>>     
>>>>
>>>>
>>>>>On Monday 26 December 2005 14:38, Steven Rostedt wrote:
>>>>>       
>>>>>
>>>
>>>[snip]
>>>   
>>>
>>>
>>>>>>I use pine and evolution.  Pine is text based and great when I ssh into
>>>>>>my machine to work.  Evolution is slow, but plays well with pine and it
>>>>>>handles things needed for LKML very well. (the drop down menu "Normal"
>>>>>>may be changed to "Preformat", which allows of inserting text files
>>>>>>"as-is").
>>>>>>         
>>>>>>
> 
> This is also the way to do it with Thunderbird. It will do the right
> thing (and disables all formatting changes such as line wrapping to the
> inserted text) if you select 'Preformat' before pasting in a patch - at
> least my Thunderbird 1.0.7 does this.
> 
> 
>>>>>Dare I say it, KMail has also been doing the Right Thing for a long time.
>>>>>It will only line wrap things that you insert by typing; pastes are left
>>>>>untouched.
>>>>>       
>>>>>
>>>>
>>>>It seems that of all the popular mail clients only Thunderbird has this
>>>>problem.  AFAICT it's impossible to make it DTRT with inline patches and
>>>>even if it is the fact that most users get it wrong points to a serious
>>>>usability/UI issue.
>>>>
>>>>Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
>>>>SubmittingPatches be accepted?  Then we can point the Mozilla developers
>>>>at it (they have shown zero interest in fixing the problem so far) and
>>>>hopefully this will light a fire under someone.
>>>>     
>>>>
>>>
>>>Fundamentally the issue with Thunderbird is that it line-wraps AFTER you 
>>>compose an email, not during composition. I've never understood how, or why 
>>>this is useful to the end user, except for composing HTML emails (which 
>>>should be banned anyway).
>>>   
>>>
> 
> Thunderbird will not linewrap anything that is inserted in 'Preformat' mode.
> 
> 
>>>Thunderbird is Yet Another mailer that could have been a good piece of 
>>>software if it hadn't attempted to be a clone of Outlook Express (defaulting 
>>>to Top Posting, HTML composition, line wrapping pastes).
>>>
>>>It's the mindset; fixing Thunderbird is probably easy, but convincing the 
>>>Mozilla developers to include such "fixes" is probably much harder.
>>>
>>>   
>>>
>>
>>Should be trivial to fix, when the user puts the editor into "Preformat"
>>mode or inserts a text file you surround it with <pre> tags.
>> 
>>
> 
> Fix the user behaviour you mean? Get them to select 'Preformat' before
> pasting patches into Thunderbird.

In my thunderbird, the "Paste Without Formatting" mode seems to be 
continually grayed out (i.e. unavailable).  I couldn't find anything in 
the preferences that altered this situation.  What's the secret?

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
