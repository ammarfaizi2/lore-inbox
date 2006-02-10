Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWBJVBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWBJVBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWBJVA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:00:58 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:11052 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751158AbWBJVA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:00:56 -0500
Date: Fri, 10 Feb 2006 16:00:54 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD-blanking leads to machine freeze with current -git [was: Re: CD
 writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring
 up a hornets' nest) ]]
In-reply-to: <B144E8F3-337C-4B1C-B46C-B97FD3EFBAB1@mac.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602101600.54794.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
 <200602101439.53394.gene.heskett@verizon.net>
 <B144E8F3-337C-4B1C-B46C-B97FD3EFBAB1@mac.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 15:12, Kyle Moffett wrote:
>On Feb 10, 2006, at 14:39, Gene Heskett wrote:
>> On Friday 10 February 2006 14:19, Phillip Susi wrote:
>>> Marc Koschewski wrote:
>>>> I just tried blanking a CD-RW with the latest -git tree. The
>>>> machine just became unresponsive and then froze. When it became
>>>> unresponsive the clock in GNOME still displayed the current time
>>>> but I could not focus any windows anymore. Then I had to hard
>>>> reboot the machine. The logs say nothing. I repeat: nothing.
>>>>
>>>> Does anyone have similar problems?
>>>
>>> Instead of rebooting, just wait for the blanking to finish.  My
>>> guess is that your burner and hard drive are both on the same ide
>>> channel, and so you can not access the disk while the burner is
>>> blanking.  If this is the case, put each drive on their own ide
>>> channel.
>>
>> It takes hard drive access to switch window focus? Yes, thats a
>> question.
>
>Depends on your programs and RAM.  If the program you try to switch
>to (or, say, part of X or your window manage) is swapped out for some
>reason, then yes, changing focus may cause said program to hang until
>it can swap the data in.  Usually that's a small fraction of a
>second, but if your IDE bus is waiting for a burn, then it could be
>the duration of the burn.
>
>Cheers,
>Kyle Moffett
>
Entirely possible I suppose, but I've seen it here quite a few times 
when there was no swap involved, I've a gig of ram, so I would, just on 
the evidence, have to assume something went gaga and its time to hit 
the reset button.  cd blanking here is a just a few seconds operation 
generally as I don't normally do the whole disk, thats a waste of time.

I've seen swap used here only one time since I rebuilt with a gig of ram 
nearly 2 years ago now.  Uptime about 2 days, memory according to htop 
is 384 megs used.

>--
>Premature optimization is the root of all evil in programming
>   -- C.A.R. Hoare

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
