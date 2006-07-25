Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751487AbWGYSh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbWGYSh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWGYSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:37:56 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:2508 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751481AbWGYShz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:37:55 -0400
Message-ID: <44C664F7.2050604@cmu.edu>
Date: Tue, 25 Jul 2006 14:37:43 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, akpm@osdl.org
Subject: Re: ACPI bombing, ACPI Exception (acpi_bus-0071): AE_NOT_FOUND
References: <CFF307C98FEABE47A452B27C06B85BB6010E42CF@hdsmsx411.amr.corp.intel.com> <20060725110434.06408186.kristen.c.accardi@intel.com>
In-Reply-To: <20060725110434.06408186.kristen.c.accardi@intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kristen Carlson Accardi wrote:
> On Tue, 25 Jul 2006 09:44:06 -0700
> "Brown, Len" <len.brown@intel.com> wrote:
> 
>>>> Hey guys,
>>>>
>>>> I am running a 2.6.18-rc1-git7 kernel on my IBM Thinkpad x60s, with
>>>> CONFIG_ACPI_DOCK=y
>>>>
>>>> Whenever the computer is inserted into the dock, ACPI seems to bomb:
>>>> http://rafb.net/paste/results/GW5E8747.html
>>>>
>>>> I was wondering if anyone could help me solve this problem, 
>>> I believe it
>>>> is keeping me from using my cdrom drive on the dock since it does not
>>>> show up in /dev.  I have also contacted Kristen Accardi 
>>> about it, who I
>>>> believe wrote the dock code... but I wasn't sure if this is a further
>>>> problem in ACPI somewhere.
>>>>
>>>> Here is my full config:
>>>> http://rafb.net/paste/results/o2gSVu90.html
>>>>
>>>> Thanks!
>>>> George
>>> Hello everyone,
>>> I am working on getting an x60 to duplicate the cdrom issue 
>>> this week.  However, I was wondering if there was anything we 
>>> could do about these AE_NOT_FOUND messages.  A lot of people 
>>> believe that they are errors, but in fact they are normal for 
>>> hotplugging.  Would it be ok if I just get rid of that error 
>>> message?  It generates unneccessary consternation.
>> In 2.6.17, this was a DEBUG message.
>> I'll return it to being a DEBUG message for 2.6.18.
>>
>> BTW. I can't follow the URLs above, hopefully you can.
>> stashing logs in a bugzilla entry is generally a better method,
>> because "bugzilla never forgets".
>>
>> thanks,
>> -Len
> 
> I can't follow them either, but I had looked at them earlier in the week when George contacted me privately. Of course, I stupidly didn't save them then. George, can you make sure you have all this information stored in a bugzilla entry, and the bugzilla can be assigned to me.
> 
> Thanks,
> Kristen
> 

Ahhh, i thought nopaste was forever.  I will definitely put this in a
bugzilla entry and regenerate it.  My dock is at my apartment, when I
get there tonight I will do it.

Thanks!
George
