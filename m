Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751821AbWEPNLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbWEPNLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWEPNLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:11:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:34439 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751820AbWEPNLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:11:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BnhuBM9KtbQcB+nHEnWWgWCjC65clRdZzMoKtR8onasjgWYSq3bt+G892FG94+iC1HknbYk+sX9j421u/FRrMAfNcabSbyRncHnaJAUMhps07w3dromuT52ydMEnc9TM7v2oroFvFAKPZtk65vcsN0pymXFZcfgTkAy9uke0BL0=
Message-ID: <4469CF8D.9080908@gmail.com>
Date: Tue, 16 May 2006 22:11:41 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: albertl@mail.com
CC: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>,
       Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca> <4469C024.3030506@gmail.com> <4469CC22.1010500@tw.ibm.com>
In-Reply-To: <4469CC22.1010500@tw.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Lee wrote:
> Tejun Heo wrote:
>> Fortier,Vincent [Montreal] wrote:
>>
>>>>> Now I'm having an ASUS A8V Deluxe.... and sadly a lot of problems:
>>>>>
>>>>> - My SATA Controller make my Linux crash when connecting a Plextor
>>>>> 716SA CD-DVD-R (http://bugzilla.kernel.org/show_bug.cgi?id=5533)
>>>
>>>> Patch:
>>>>
>>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-
>>> git2-libata1.patch.bz2
>>>
>>>> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
>>> 2.6.17-rcX[-gitY] kernels)
>>>
>>> I gave a try at the latest ata patches announced yesterday by Jeff and
>>> it completelly solved my SATA ATAPI bug.. I even been able to burn my
>>> first DVD using my Plextor 716SA on my Linux!!!  Really nice and much
>>> anticipated work!  Thnx a lot!
>>>
>>> I have already marked bug 5533 as resolved and I'll wait until inclusion
>>> into 2.6.18 to close it.  I've also marked bug 6317 has closed since
>>> that did not occur since around rc2 or rc3 of 2.6.17.
>>>
>> Jeff, do you know what fixed this one?  I've been following the bug and
>> thought it was one of those via-ATAPI-have-no-idea bugs.  How come the
>> update fix this one?  Have I missed something?
>>
> 
> I'm also curious how the svia-atapi problem got fixed.

This is funny.  I thought you would know.  We're just a bunch of 
clueless people, aren't we?  :-)

Fortier, can you please post full boot dmesg?

-- 
tejun
