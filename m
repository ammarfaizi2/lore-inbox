Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVLLSxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVLLSxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVLLSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:53:34 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:43784 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S932135AbVLLSxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:53:33 -0500
In-Reply-To: <200512121717.jBCHHqHe017137@laptop11.inf.utfsm.cl>
References: <200512121717.jBCHHqHe017137@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1E7AE38-6D7C-4CE6-847E-8F1608F66D77@oxley.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
Date: Mon, 12 Dec 2005 18:53:30 +0000
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Dec 2005, at 17:17, Horst von Brand wrote:

> Felix Oxley <lkml@oxley.org> wrote:
>
> [...]
>
>> What if ...
>>
>> 1. When people make a patch set, if they have encountered any 'bugs'
>> they split them out as separate items.
>
> No need. Patches are either (a) bug fixes, or (b) infrastructure  
> changes,
> or (c) additions (mostly drivers). You only need to pick (a) items.  
> Check.
>
>> 2. The submitter would identify through GIT when the error had been
>> introduced
>
> Hard to find out. Nobody will do so.
>
>>            so that the the person responsible could be CC'ed, also
>> anybody who had worked on the code recently would be CCed, therefore
>> the programmers who were most familiar with that section of code
>> would be made aware of it.
>
> Cc:ing them is part of the development anyway (in reality, Cc:ing  
> anybody
> interested in the area). Check.
>
>> 3. When the patch is posted to LKML, it is tagged [PATCH][FIX] in the
>> subject line.
>>      In the body of the fix would be noted each kernel to which the
>>      fix applied e.g [FIX 2.6.11][FIX 2.6.12][FIX 2.6.13][FIX 2.6.14]
>
> No do. Problem are the (b) and (c) patches above, they change  
> whatever the
> patch applies to and make it not apply anymore. The effort of  
> finding out
> if the patch is (a) or (c) class, seeing if it is really needed, and
> modifying it so it applies to your source base is called  
> "backporting". And
> it remains hard, thankless work.

If this was done for 'trivial' patches of type (a):
	1. Would that make it simple enough for people to actually do it?
	2. Would it be worthwhile? (Are there enough 'trivial fixes'?)

I envisaged something like the current Stable series, just for longer  
than a single release cycle.

>> 4. The programmers mentioned in (2) would ACK the patch which would
>> then become part of an 'official' fixes list.
>
> Won't happen.
>
>> 5. If a volunteer wanted to maintain, say, 2.6.14 + fixes, they could
>> build and test it and be a point of contact regarding any problems.
>> These could hopefully be tracked down and submitted as a new fix  
>> patch.
>
> Go right ahead. Just be warned that distributions hired a small  
> army of
> kernel specialists to do exactly this, and got tired of doing so.  
> Among
> others because the patches deemed necessary were different from one
> distributuion to the next, and then usually incompatible with one  
> another
> and with what turned out to be the standard solution. This gave  
> rise to the
> current development model...
>
> Armchair software engineering is much like armchair $SPORT.

I am guilty :-)

Thanks for your reply.

regards,
Felix
