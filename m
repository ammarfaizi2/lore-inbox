Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWHRD5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWHRD5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 23:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHRD5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 23:57:04 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:46254 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932344AbWHRD5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 23:57:02 -0400
Date: Thu, 17 Aug 2006 23:57:15 -0400
From: Lee Trager <Lee@PicturesInMotion.net>
Subject: Re: Merging libata PATA support into the base kernel
In-reply-to: <44E53635.3080702@PicturesInMotion.net>
To: Lee Trager <Lee@PicturesInMotion.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Jason Lunz <lunz@falooley.org>,
       Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Stefan Seyfried <seife@suse.de>
Message-id: <44E53A9B.6080701@PicturesInMotion.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <1155144599.5729.226.camel@localhost.localdomain>
 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
 <20060817091842.GC17899@elf.ucw.cz>
 <1155808348.15195.55.camel@localhost.localdomain>
 <20060817094512.GD17899@elf.ucw.cz>
 <1155815491.15195.75.camel@localhost.localdomain>
 <44E53635.3080702@PicturesInMotion.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060731)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Trager wrote:
> Alan Cox wrote:
>   
>> Ar Iau, 2006-08-17 am 11:45 +0200, ysgrifennodd Pavel Machek:
>>   
>>     
>>> This should not be it... it also happens on suspend-to-disk according
>>> to the report, and during swsusp we do normal boot so HPA should be
>>> initialized...?
>>>     
>>>       
>> The suspend to disk case I've not personally seen. The suspend to ram
>> one I have looked at and seen and verified the HPA was not reset.
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>   
>>     
> Well how do we reset HPA? If someone could point me in the right
> direction I could try to get it to work, although I've never really done
> any kernel hacking before. Im not even sure what HPA is, Wikipedia has
> nothing on it so I guess I'll google around.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   
Ok I got it now. Anyway I tried disabling it in the BIOS(IBM called it
the Predesktop Area) and I still get the same thing.
