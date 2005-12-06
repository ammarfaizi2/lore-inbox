Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVLFQxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVLFQxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 11:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVLFQxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 11:53:55 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:26954 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932325AbVLFQxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 11:53:54 -0500
Date: Tue, 06 Dec 2005 11:52:57 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-reply-to: <8764q2qq8f.fsf@mid.deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Message-id: <200512061152.57396.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512060110.jB61AMHF004027@pincoya.inf.utfsm.cl>
 <8764q2qq8f.fsf@mid.deneb.enyo.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 09:01, Florian Weimer wrote:
>* Horst von Brand:
>>> You mentioned security issues in your initial post.  I think it
>>> would help immensely if security bugs would be documented properly
>>> (affected versions, configuration requirements, attack range, loss
>>> type etc.) when the bug is fixed, by someone who is familiar with
>>> the code. (Currently, this information is scraped together mostly by
>>> security folks, sometimes after considerable time has passed.) 
>>> Having a central repository with this kind of information would
>>> enable vendors and not-quite-vendors (people who have their own set
>>> of kernels for their machines) to address more vulnerabilties
>>> promptly, including less critical ones.
>>
>> I've fixed bugs which turned out to be security vulnerabilities. And
>> I didn't know (or even care much) at the time. Finding out if some
>> random bug has security implications, and exactly which ones/how much
>> of a risk they pose is normally /much/ harder than to fix the bugs.
>
>I know, it happens all the time: vulnerabilities are fixed because
>they are bugs, and not because they are vulnerabilities.  It's
>unfortunate if people are unnecessarily exposed to the vulnerability
>(because they don't know about it and don't apply the fix as a result),
>but it's better than carrying around the bug indefinitely.
>
>But if there's considerable evidence that you might have fixed a
>security bug, preserving this information (and other bits that are
>immediately obvious to you as a developer, but not necessarily who
>reviews the issue) seems worthwhile.  Maybe you don't want to put it
>into the public commit message, but forwarding what you have to some
>trusted group of volunteers would make sense.  The volunteers would
>distill the information, add more data and assign a CVE if necessary,
>and declassify the information as soon as the public is ready (in the
>form of a short security advisory, like the ones you see for most
>applications).
>
>Does this sound too far-fetched?  Why don't you think this would be a
>valuable service to all users, vanilla kernels or not?

But, as you'll recall, ALan Cox fixed a couple of major security things 
about 2 years ago, and because of the DMCA, those patches weren't 
commented at all.  Apparently the fix could only be determined to be 
correct by violating the DMCA, and he was very pointed in his comments 
re the DMCA at the time.

So keeping good records might/could be a double edged sword.

>> And rather pointless, after the fix is in.
>
>It doesn't matter much if the fix is in the kernel.org tree, when I'm
>supposed to use vendor kernels. 8-)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.36% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
