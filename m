Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVLNAJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVLNAJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 19:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVLNAJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 19:09:16 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:58386 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030371AbVLNAJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 19:09:15 -0500
In-Reply-To: <200512131317.jBDDHFFr004724@laptop11.inf.utfsm.cl>
References: <200512131317.jBDDHFFr004724@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DDBB5F0C-8CE1-4A77-B005-798B3701EC99@oxley.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
Date: Wed, 14 Dec 2005 00:09:09 +0000
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Dec 2005, at 13:17, Horst von Brand wrote:

> Felix Oxley <lkml@oxley.org> wrote:
>> On 12 Dec 2005, at 17:17, Horst von Brand wrote:
>>> Felix Oxley <lkml@oxley.org> wrote:
>>>
>>> [...]
>>>
>>>> What if ...
>>>>
>>>> 1. When people make a patch set, if they have encountered any  
>>>> 'bugs'
>>>> they split them out as separate items.
>
>>> No need. Patches are either (a) bug fixes, or (b) infrastructure
>>> changes, or (c) additions (mostly drivers). You only need to pick  
>>> (a)
>>> items. Check.
>
> [...]
>
>>>> 3. When the patch is posted to LKML, it is tagged [PATCH][FIX]  
>>>> in the
>>>> subject line.
>>>>      In the body of the fix would be noted each kernel to which the
>>>>      fix applied e.g [FIX 2.6.11][FIX 2.6.12][FIX 2.6.13][FIX  
>>>> 2.6.14]
>
>>> No do. Problem are the (b) and (c) patches above, they change
>>> whatever the patch applies to and make it not apply anymore. The  
>>> effort
>>> of finding out if the patch is (a) or (c) class, seeing if it is  
>>> really
>>> needed, and modifying it so it applies to your source base is called
>>> "backporting". And it remains hard, thankless work.
>>
>> If this was done for 'trivial' patches of type (a):
>> 	1. Would that make it simple enough for people to actually do it?
>> 	2. Would it be worthwhile? (Are there enough 'trivial fixes'?)
>
> Not all important fixes are "trivial", far from it; so this is rather
> suspect in any case. Changes to the underlying source make even  
> "trivial"
> patches soon not apply anymore. And there still is the job of  
> finding out
> if some patch is or is not necessary...
>
>> I envisaged something like the current Stable series, just for longer
>> than a single release cycle.
>
> Go right ahead. If enough people get interested and work on it, it  
> might
> turn out useful. I rather doubt it, as the current development  
> model is
> exactly geared towards keeping people up to date, not running ancient
> kernels and then jumping a few versions ahead. The problem with  
> doing that
> is that instead of one problem at a time you see a dozen, and then  
> it is
> hard to pin down /when/ it broke (and thus what change is  
> responsible).
> Plus the drift from backported patches, where you can't be sure it / 
> seemed/
> to work because of some random patch.
>
> Again, this development model was tried /hard/ for some 12 years by  
> the
> distributions, and found sorely lacking (and essentially unfixable).

Thank you for your explanation.
I will retire to lurk quietly in my armchair.  :-)

regards,
Felix
