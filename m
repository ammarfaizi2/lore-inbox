Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWEPM5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWEPM5Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbWEPM5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:57:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1979 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751816AbWEPM5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:57:24 -0400
Message-ID: <4469CC22.1010500@tw.ibm.com>
Date: Tue, 16 May 2006 20:57:06 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>,
       Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <4469C024.3030506@gmail.com>
In-Reply-To: <4469C024.3030506@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Fortier,Vincent [Montreal] wrote:
> 
>>>> Now I'm having an ASUS A8V Deluxe.... and sadly a lot of problems:
>>>>
>>>> - My SATA Controller make my Linux crash when connecting a Plextor
>>>> 716SA CD-DVD-R (http://bugzilla.kernel.org/show_bug.cgi?id=5533)
>>
>>
>>> Patch:
>>>
>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-
>> git2-libata1.patch.bz2
>>
>>> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
>>
>> 2.6.17-rcX[-gitY] kernels)
>>
>> I gave a try at the latest ata patches announced yesterday by Jeff and
>> it completelly solved my SATA ATAPI bug.. I even been able to burn my
>> first DVD using my Plextor 716SA on my Linux!!!  Really nice and much
>> anticipated work!  Thnx a lot!
>>
>> I have already marked bug 5533 as resolved and I'll wait until inclusion
>> into 2.6.18 to close it.  I've also marked bug 6317 has closed since
>> that did not occur since around rc2 or rc3 of 2.6.17.
>>
> 
> Jeff, do you know what fixed this one?  I've been following the bug and
> thought it was one of those via-ATAPI-have-no-idea bugs.  How come the
> update fix this one?  Have I missed something?
> 

I'm also curious how the svia-atapi problem got fixed.

Reinhard has a Plextor PX-712SA + svia.
Maybe he can also help to check whether the patch fixes the problem on his box.

--
albert

