Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVCVHCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVCVHCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 02:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVCVHAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 02:00:48 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:51874 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262040AbVCUWcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:32:03 -0500
X-Spam-Report: SA TESTS
 -1.7 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                             [score: 0.0000]
Message-ID: <423F4B88.8020504@twisted-brains.org>
Date: Mon, 21 Mar 2005 23:32:40 +0100
From: Mws <mws@twisted-brains.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Paulo Marques <pmarques@grupopie.com>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org> <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org> <423727BD.7080200@grupopie.com> <20050321101441.GA23456@elf.ucw.cz> <423EEEC2.9060102@lougher.demon.co.uk> <20050321190044.GD1390@elf.ucw.cz>
In-Reply-To: <20050321190044.GD1390@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
-snip-

>>>So we are replacing severely-limited cramfs with also-limited
>>>squashfs... 
>>>      
>>>
>>I think that's rather unfair, Squashfs is significantly better than 
>>cramfs.  The main aim of Squashfs has been to achieve the best 
>>    
>>
>
>Yes, it *is* rather unfair. Sorry about that. But having 2 different
>limited compressed filesystems in kernel does not seem good to me.
>
>  
>
what do you need e.g. reiserfs 4 for? or jfs? or xfs? does not ext2/3 
the journalling job also?
is there really a need for cifs and samba and ncpfs and nfs v3 and nfs 
v4? why?

-snip-

>Well, out-of-tree maintainenance takes lot of time, too, so by keeping
>limited code out-of-kernel we provide quite good incentive to make
>those limits go away.
>
>Perhaps squashfs is good enough improvement over cramfs... But I'd
>like those 4Gb limits to go away.
>								Pavel
>  
>
we all do - but who does really care about stupid 4Gb limits on embedded 
systems with e.g.
8 or 32 Mb maybe more of Flash Ram? really noboby

if you want to have a squashfs for DVD images e.g. not 4.7Gb but  
DualLayer ect., why do you complain?
you are maybe not even - nor you will be - a user of squashfs. but there 
are many people outside that use
squashfs on different platforms and want to have it integrated to 
mainline kernel. so why are you blocking?

did you have a look at the code? did you find a "trojan horse"?
no and no? so why are you blocking? if the coding style is not that what 
nowadays kernel coder have as
coding style? if you care - fix it - otherwise give hints and other 
people will do.

regards
marcel

