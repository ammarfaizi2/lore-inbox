Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVKSTPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVKSTPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVKSTPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:15:00 -0500
Received: from 8.ctyme.com ([69.50.231.8]:55244 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1750753AbVKSTO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:14:59 -0500
Message-ID: <437F79B1.9050703@perkel.com>
Date: Sat, 19 Nov 2005 11:14:57 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk>
In-Reply-To: <200511191900.12165.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alistair John Strachan wrote:

>On Saturday 19 November 2005 19:01, Alan Cox wrote:
>  
>
>>On Sad, 2005-11-19 at 09:41 -0800, Marc Perkel wrote:
>>    
>>
>>>Trying to save power consumption. I have a backup drive that is used
>>>only once a day to back up the main drive. So - why should I run it more
>>>that 10 minutes a day? What I'd like to do is keep it in an off state
>>>and then at night power it on, mount it up, do the backup, unmount it,
>>>and shut it down. Can I do that?
>>>      
>>>
>>SATA not yet, USB you could however.
>>    
>>
>
>Or PATA, of course. I switch off two of my HDs 4 minutes after last use with 
>the commands:
>
>hdparm -S 48 /dev/hde
>hdparm -S 48 /dev/hdg
>
>Isn't there a passthru patch in the works to let commands, such as the one 
>required for suspend, through to a SATA device?
>
>  
>

So - why isn't there more SATA support. Seems like this and SMART aren't 
supported. What's up with that? Why is SATA harder than IDE?

-- 
Marc Perkel - marc@perkel.com

Spam Filter: http://www.junkemailfilter.com
    My Blog: http://marc.perkel.com

