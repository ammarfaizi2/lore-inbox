Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVCCPBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVCCPBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVCCPBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:01:17 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:19176 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261791AbVCCPAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:00:45 -0500
Message-ID: <42272699.8020206@dgreaves.com>
Date: Thu, 03 Mar 2005 15:00:41 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302235206.GK3163@waste.org>
In-Reply-To: <20050302235206.GK3163@waste.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>On Wed, Mar 02, 2005 at 02:21:38PM -0800, Linus Torvalds wrote:
>  
>
>>This is an idea that has been brewing for some time: Andrew has mentioned
>>it a couple of times, I've talked to some people about it, and today Davem
>>sent a suggestion along similar lines to me for 2.6.12.
>>
>>Namely that we could adopt the even/odd numbering scheme that we used to 
>>do on a minor number basis, and instead of dropping it entirely like we 
>>did, we could have just moved it to the release number, as an indication 
>>of what was the intent of the release.
>>    
>>
>
>One last plea for the 2.4 scheme:
>
> a) all the crazy stuff goes in 2.6.x-preN, which ends up being
>    equivalent to 2.6.<odd> and friends in your scheme
> b) bugfixes only in 2.6.x-rcN, which ends up being equivalent to
>    2.6.<even>-* in your scheme.
> c) 2.6.x is always 2.6.x-rc<last> with just a version number change[1]
>
>This has some nice features:
>
> - alternates as rapidly as you want between stable and development
> - no brown paper bag bugs sneaking in between -rc<last> and 2.6.x 
> - 2.6.* is suitable for all users, 2.6.*-rc* is suitable for almost
>   all users
> - it's already in use for 2.4 and people are happy with it
>
>  
>

I understand that :)
(and if 2.6.y+1-preX appeared before 2.6.y then that wouldn't be too 
confusing)
(neither would 2.6.y.1 as an 'oops' in the human sense)

--Joe User.

Who's scared to risk his personally valuable data on a 
2.6.x-pre<anything> - but will install, lets see, hmm, -rc2 or above :)
(I suppose the more paranoid I get, the higher the watermark I set on -rcX)

(I'm lying since I'm running a -mm on my server but that's only because 
I helped track down an XFS/nfsd bug!)

