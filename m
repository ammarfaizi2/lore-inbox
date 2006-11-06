Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753196AbWKFOUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbWKFOUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbWKFOUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:20:40 -0500
Received: from 8.ctyme.com ([69.50.231.8]:30129 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1753196AbWKFOUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:20:39 -0500
Message-ID: <454F44B6.4090305@perkel.com>
Date: Mon, 06 Nov 2006 06:20:38 -0800
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: could not find filesystem /dev/root
References: <454E95E1.2010708@perkel.com>	 <873b8wubcc.fsf@barad-dur.regala.cx> <1162808799.3160.197.camel@laptopd505.fenrus.org>
In-Reply-To: <1162808799.3160.197.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arjan van de Ven wrote:
> On Mon, 2006-11-06 at 11:18 +0100, Mathieu SEGAUD wrote:
>   
>> Vous m'avez dit récemment :
>>
>>     
>>> Trying to compile a new kernel and getting this on boot
>>>
>>> could not find filesystem /dev/root
>>>       
>> sure it doesn't spit only this to you. Does it panic ? and do FC6
>> kernels use an initrd (I guess so) ?
>>     
>
> they do and it's more or less required there (for mount-by-label and
> many other things).
>
> But it's easy to do.
> In fact, if you use "make install" as the last step in your build
> process, the kernel build process will
> 1) copy the bzImage over to /boot for you
> 2) make an initrd for your system
> 3) add the kernel and initrd to grub for you
>
> this is a very convenient step that makes it very robust to do, and
> beats doing the manual thing even if you wouldn't do an initrd in terms
> of convenience..
>   

Yes - I run make - make modules_install - make install. It creates the 
initrd files and it alters grub. The stock kernel works and in the past 
compiling my own kernel this way worked. I even started with Fedora's 
.config file. to make sure I'm compiling the same stuff.


