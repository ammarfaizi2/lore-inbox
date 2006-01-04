Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbWADOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWADOEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 09:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWADOEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 09:04:04 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:32489 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751259AbWADOED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 09:04:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=OhZut+BP2wVIHcxMWM4kEafOoYknQ1oaPfjIlPBcNtJTrxJc8D7wCTJ1WkG/lnDUdqexQtOAoy6vBnK9u7t3JXFkg92wYpOadVlLyh4QeiGIbUFxDiBGwYbrVbkyfgXjkh1+uMxC71ACNv+vHTdf2CnUM58O9k7kYObvivS4i3s=
Message-ID: <43BBD5CC.6040905@gmail.com>
Date: Wed, 04 Jan 2006 15:03:56 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
References: <5r1ql-4Af-11@gated-at.bofh.it> <5r2mU-63n-79@gated-at.bofh.it> <5r2FQ-6FS-37@gated-at.bofh.it> <5r3C3-88G-55@gated-at.bofh.it> <5r4ey-wy-17@gated-at.bofh.it> <5r4of-Wo-39@gated-at.bofh.it> <5r50O-1IR-3@gated-at.bofh.it> <5r5k8-2kx-1@gated-at.bofh.it> <5r72E-4AS-5@gated-at.bofh.it> <5rcOF-4ci-1@gated-at.bofh.it> <5rgSv-1KJ-41@gated-at.bofh.it>
In-Reply-To: <5rgSv-1KJ-41@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Louis ha scritto:
> On 20060104 (Wed) at 0850:34 +0000, Alan Cox wrote:
> 
>>On Mer, 2006-01-04 at 03:51 +0100, Tomasz K??oczko wrote:
>>
>>>Be compliant with OSS specyfication allow save many time on applications 
>>>development level by consume (in good sense) time spend on this 
>>>applications by *BSD, Solaris and other systems developers (even on not 
>>>open source applications).
>>
>>Both Solaris and FreeBSD contain Linux emulation code so in that sense
>>they admitted 'defeat' long ago.
>>
>>
>>>valuable functionalities in usable/simpler form for joe-like users .. 
>>>remember: sound support in Linux isn't for data centers/big-ass-machines :)
>>
>>And distributions nowdays ship with ALSA by default, which is giving
>>users far better audio timing behaviour, mixing they want, digital and
>>analogue 5.1 outputs. OSS really isn't ideal for serious "end user"
>>applications like video playback
>>
> 
> Ok, so I'm not serious :) just wanna do fairly standard audio things.
> 
> - ALSA doesn't (AFAIK, haven't checked for a few months) support my old
>   Audiotrix sound card -- bye, machine 1
> - ALSA can't be persuaded (not by me, anyway) to drive my VIA
>   ac97_codec onboard sound hardware -- everything works fine except
>   unmuting ;) -- bye, machine 2
> - ALSA does suport my i810_audio ac97_codec laptop, but so does OSS,
>   equally well (for my unsophisticated needs) and with a far less
>   elephantine footprint in memory. -- strike 3, ALSA out.
> 
> So even if sound support in Linux _is_ for "big-ass" studio work, it
> would be nice if little guys didn't get abandoned along the way, IMHO.
> 

if you miss some drivers, you can add them (or ask for that) written in
alsa driver.

and if your chipset works with alsa as with oss that's not a good
motivation not to remove OSS.

think about audigy2 users :)

ps. i've an old ens1370 card..so that's not me

	Patrizio

--
Patrizio Bassi
www.patriziobassi.it
