Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVKENTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVKENTU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 08:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKENTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 08:19:20 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:44426
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751212AbVKENTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 08:19:19 -0500
Message-ID: <436CB162.5070100@ed-soft.at>
Date: Sat, 05 Nov 2005 14:19:30 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
References: <436C7E77.3080601@ed-soft.at> <20051105122958.7a2cd8c6.khali@linux-fr.org>
In-Reply-To: <20051105122958.7a2cd8c6.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry for not posting my Name.

Maybe you don't understand what i wanted to say or it's my bad english.
The ipw2200 driver was only an example. I had also problems with, vmware,
unionfs...
What i mean ist, that kernel developers make incompatible changes to the 
header
files, change structures, interfaces and so on. Which makes the kernel 
releases
incompatible.
There are several reasons why modules are not in the mainline kernel and 
will never
get there. So saying, bring modules to the kernel is wrong.
The right way would be to take care of defined interfaces, header files, 
and so on.
Otherwise you could only say the kernel 2.6.14 is only compatible to 
2.6.14.X and
you there is no stable 2.6 mainline kernel.
I think it's also no task for the user, to search the net why external 
driver xyz not
works with a new kernel ( because of incompatibilties ). Basicly in new 
kernel there
could be a chance for the user a driver works better, because a bug was 
fixed in the
kernel.
Hopefully this time it's more clear why i blame the development process 
and i'm a
so frustrated linux user.

cu

ED.
 

Jean Delvare wrote:

>Hi, huh...
>
>... don't you have a real name? Posting as "hostmaster" may impress
>teenagers, but over there we tend to prefer people with real names.
>
>  
>
>>I tought long about writting this mail. I'm a linux use since many years.
>>At the moment i'll getting more then frustrated about the actual develoment
>>model of the kernel. In the latest releases things where broken from release
>>to release.
>>For example take the ipw2200 driver.
>> From 2.6.12 -> 2.6.13 the header file ieee80211.h was incompatible with 
>>driver.
>>Also transfer speed decreased dramaticaly.
>> From 2.6.13 -> 2.6.14 you included the ipw2200 driver. But in an too 
>>old version without WPA support.
>>(...)
>>I realy liked it to have the latest state of the art kernel, but at the 
>>moment i'm forced to use 2.6.12 ( ipw2200 -> WPA ).
>>    
>>
>
>Your problems seem to be very specific to wireless networking, right?
>Blaming the whole development model because one area seems to have
>problems is a bit awkward, don't you think? Report to the persons
>responsible for that area and/or specific driver, tell them about the
>problem, they'll surely listen to you and improve the process if
>possible.
>
>Also, the point you mention for the 2.6.13 -> 2.6.14 transition is
>irrelevant with regards to the development model. With a different
>development model, the driver wouldn't have been added at all. This
>wouldn't have made any difference for you as far as I can see.
>
>  
>
>>The external driver on ipw2200.sourceforge.net seems not to work
>>with 2.6.14.
>>(...)
>>I had also several problems with some other not in kernel drivers.
>>    
>>
>
>Third party drivers don't work, and you complain to us. What's the
>point?
>
>  
>
>>I can't understand it why you have to break compatibility from kernel 
>>release to kernel release.
>>    
>>
>
>You should read this document:
>http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/stable_api_nonsense.txt
>
>  
>
>>Don't you think that this makes 3'rd party driver developers
>>frustrated?
>>    
>>
>
>We don't care. It's their choice, not ours.
>
>  
>
>>It can't be an option for 3'rd party developers and users to check if 
>>external drivers still works with new kenrel releases.
>>    
>>
>
>It is. If they are not happy with that, they simply get their code
>integrated into the main Linux tree, and get to work with us rather
>than apart on their own. It's easier for us, it's easier for them,
>and it's easier for the users. Everyone benefits.
>
>  
>
>>From my point of view the actual linux kernel is far away from a stable 
>>development process.
>>    
>>
>
>Yet you don't propose anything to improve it?
>
>  
>

