Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbVLWKSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbVLWKSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVLWKSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:18:06 -0500
Received: from [195.144.244.147] ([195.144.244.147]:16080 "EHLO
	amanaus.varma-el.com") by vger.kernel.org with ESMTP
	id S1030478AbVLWKSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:18:05 -0500
Message-ID: <43ABCED6.2030008@varma-el.com>
Date: Fri, 23 Dec 2005 13:17:58 +0300
From: Andrey Volkov <avolkov@varma-el.com>
Organization: Varma Electronics Oy
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ru-ru, ru
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: pantelis.antoniou@gmail.com, linuxppc-embedded@ozlabs.org,
       Jes Sorensen <jes@trained-monkey.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] genalloc != generic DEVICE memory allocator
References: <43A98F90.9010001@varma-el.com> <yq0d5jpuoqe.fsf@jaguar.mkp.net> <43AAEE12.5030009@varma-el.com> <200512222033.40156.pantelis.antoniou@gmail.com> <43ABA972.4080701@varma-el.com> <43ABAB69.4060703@intracom.gr>
In-Reply-To: <43ABAB69.4060703@intracom.gr>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=pgp.dtype.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pantelis Antoniou wrote:
>>
> 
> [snip]
> 
>>
>> Agree, I couldn't see nothing better for a basement of generic dev.
>> alloc.
>>
>> So, it will be much better if it will be moved to lib/.
>>
>> Anyone have some more comments about subj. ?
>>
> 
> Sure, but the call has to be made be a core developer.
> 
> Andrew?

Pantelis, what did you think about renaming rheap.c and rh_xxx, to
something like dev_xxx, since, for example, rh_alloc overlapped with
__rh_alloc (__RegionHach__alloc) in the drivers/md/dm-raid1.c.


-- 
Regards
Andrey Volkov
