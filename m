Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVHKR6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVHKR6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVHKR6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:58:17 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:10356 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932328AbVHKR6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:58:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=hmB4qzS9V20LDOIwi7FkYMzGvS7HHdfOANfvM1OUeXE3pfRME5UpJX8vjDzBR2cd5UgwKaEULV1RIYbyz4bmnW9Z5QhVeHBbpffoUINa/4EYJ+eeulrtsuQvDJ3uOfdAa7JF2h6KaOusMXemLsJ+m2H7dTfjsTq3R3tTPqa22KM=
Message-ID: <42FB9191.6050602@gmail.com>
Date: Thu, 11 Aug 2005 19:57:37 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Lee Revell <rlrevell@joe-job.com>, lgb@lgb.hu,
       Allen Martin <AMartin@nvidia.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>	 <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <42FB8D04.8050006@gmail.com> <42FB8F0D.6060202@pobox.com>
In-Reply-To: <42FB8F0D.6060202@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Michael Thonke wrote:
>
>> I have a ASUS A8V Deluxe too, and can't use the AMD X2 processor on 
>> it...this is a feature..right?
>> Supposed to run with DualCore but don't post..hm.
>
>
> What does ASUS say about this?  You can't just plug a new processor 
> into an old motherboard and expect it to work, generally.

Hello Jeff,

No they don't like AMD x2 DualCore cpus. ASUS is not interesseted in the 
bugs I found...Silicon Image helped me to get Samsung SATA II drivers 
working on the Sil3132 chip and gave me a update/firmware. But ASUS 
...what should I say? They say no problem encountered by us so 
far...don't use linux...and thorw off the phone..while you want to 
talk..*sigh*

>
>
>> My SATA II devices. Get not regonized from the VIA SATA 
>> controller...this bug is known.
>> So I want to use my HDD's I bought ...why should I set my SATA II 
>> device to be SATA I.
>
And nope they don't work, no drive which with SATAII operate without 
tweak on VIA Southbridges..SATA controller.
Hitachi,Samsung,WD

I refer to the article of heise.de
This article from heise.de is german sorry...but maybe you understand 
what they wrote

http://www.heise.de/newsticker/meldung/62189

Haven't found a

>
> Please enable ATA_DEBUG and ATA_VERBOSE_DEBUG, and send me the output.

I tried that Jeff, but the base problem is on the low-level..
Like the one I ound with Sil3132.

>
>
> SATA II devices can be used on SATA I controllers just fine, with no 
> need to tweak settings.
>
>     Jeff

Michael

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



