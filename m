Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWEPMGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWEPMGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWEPMGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:06:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:26943 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750904AbWEPMGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:06:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pUEwEYY12ynItD2xy+HVy4gdAl1SQMQbCDM3wobJ3C1iNNDPeh5WDTuz6rDSWviKIZgKMbZc3ZdoXTHS6IadJch3VmOI5oryEcKdpzy0IfngA2AwzZ68NIfbb3DUBN6heqen4Z3AyVfZ5eH9Wtrh7EDRNEmQfxxWCDiyspHEZpc=
Message-ID: <4469C024.3030506@gmail.com>
Date: Tue, 16 May 2006 21:05:56 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: Andi Kleen <ak@suse.de>, Marko Macek <Marko.Macek@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F702463F@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
>>> Now I'm having an ASUS A8V Deluxe.... and sadly a lot of problems:
>>>
>>> - My SATA Controller make my Linux crash when connecting a 
>>> Plextor 716SA CD-DVD-R 
>>> (http://bugzilla.kernel.org/show_bug.cgi?id=5533)
> 
>> Patch:
>>
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-
> git2-libata1.patch.bz2
>> (diff'd against 2.6.17-rc4-git2, but should apply to most recent
> 2.6.17-rcX[-gitY] kernels)
> 
> I gave a try at the latest ata patches announced yesterday by Jeff and
> it completelly solved my SATA ATAPI bug.. I even been able to burn my
> first DVD using my Plextor 716SA on my Linux!!!  Really nice and much
> anticipated work!  Thnx a lot!
> 
> I have already marked bug 5533 as resolved and I'll wait until inclusion
> into 2.6.18 to close it.  I've also marked bug 6317 has closed since
> that did not occur since around rc2 or rc3 of 2.6.17.
> 

Jeff, do you know what fixed this one?  I've been following the bug and 
thought it was one of those via-ATAPI-have-no-idea bugs.  How come the 
update fix this one?  Have I missed something?

-- 
tejun
