Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbRFWC50>; Fri, 22 Jun 2001 22:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265604AbRFWC5Q>; Fri, 22 Jun 2001 22:57:16 -0400
Received: from james.kalifornia.com ([208.179.59.2]:3929 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265603AbRFWC5J>; Fri, 22 Jun 2001 22:57:09 -0400
Message-ID: <3B34057D.1020409@blue-labs.org>
Date: Fri, 22 Jun 2001 19:57:01 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106230246.f5N2kfU82578@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am mixed between packing to move to the east coast right now but I 
will definitely be providing you some information.  I have to get this 
system up and running inside the next four days.  I realize this is a 
bit rude/forward of me, but I would greatly appreciate your help and 
please tolerate my rushedness :)

Justin T. Gibbs wrote:

>>Well let me put it this way, I have in no way selected 'rebuild 
>>firmware' and several of my freshly untarred/patched to kernels are 
>>broken in that they won't compile, why?  lex not found.
>>
>
>Prior to Linus' 2.4.5 release, aic7xxx version 6.1.5 was embedded
>in the kernel.  Although corrected almost immediately after its release,
>this version attempted to build the firmware at all times.  Although
>a lofty goal from an aesthetic standpoint (why should you have generated
>files when you have all the source to build them?), it simply doesn't
>work on the miriad of distributions out there.   It took a while
>for Linus to pick up the change that added the "rebuild firmware"
>config option, so you may have a kernel that still has this broken
>behavior.  Updates to most recent kernels to the latest aic7xxx driver
>can be found here:
>
>http://people.FreeBSD.org/~gibbs/linux/
>

I agree with the above except for the usage of external library headers 
such as db.h.  I tried numerous sleepycat builds but they all returned 
errors with the particular db.h.

I will shortly visit that URL and see what I can do.

>>Currently I'm pretty bothered because for any of numerous reasons now, I 
>>can't get the blasted aic7xxx support in any 2.4 kernel to work.  I'm a 
>>little tweaked because my distro is based on 2.4 functionality and I'm 
>>stuck on square 0 just trying to boot.
>>
>
>You could always choose to use the older aic7xxx driver.  To this day,
>it is still available in the 2.4.X kernels.  I don't have enough details
>about your particular problems to know if this will help your situation.
>

How does one go about choosing the older driver?  I didn't see a config 
option for it.

>>Several people have made reports about 2.4 and aic7xxx wrt to OOPSes, 
>>failure to boot, and hanging and there's very little response to this. 
>>
>
>Perhaps I've missed the reports then.  I've made every effort to repond
>to the reports that I've seen, have worked to correct those issues,
>and expect to release 6.1.14 early next week.  Unfortunately even
>working for Adaptec, our testing resources (number/type of machines)
>are limited, so there will always be some bugs left for the userbase
>to find.
>

Understandable.

>>To this point I have two machines stuck in 2.2 which desperately need 
>>upgraded but I can't upgrade the kernel because the aic code is tragic.
>>
>>Pardon my frustration,
>>David
>>
>
>Can you provide information about your system and how it fails?  I will
>need to know driver revision, type of card, and any messages you can
>copy down during a failure with "aic7xxx=verbose" set either in LILO
>for a statically compiled driver or used when loading the module.  A
>dmesg from a system booted with the 2.2 kernel should give me most of
>the system information I need.
>

I will dig out a serial cable and update the boot floppy I'm using.  Do 
you suggest I start these proceedings again with a 2.4.5+ kernel?  What 
is your recommendation on this, -preN or -acN etc?  I'll build a 2.2 and 
log the info.

David


