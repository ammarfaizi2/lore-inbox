Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSKEXxI>; Tue, 5 Nov 2002 18:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265375AbSKEXxI>; Tue, 5 Nov 2002 18:53:08 -0500
Received: from skyline.vistahp.com ([65.67.58.21]:32234 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S265373AbSKEXxG>; Tue, 5 Nov 2002 18:53:06 -0500
Message-ID: <20021106000052.21645.qmail@escalade.vistahp.com>
References: <1036525756.2291.45.camel@lotte>
            <1036539902.2291.48.camel@lotte>
In-Reply-To: <1036539902.2291.48.camel@lotte>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: Justin Cormack <justin@street-vision.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: promise ide problem: missing disks
Date: Tue, 05 Nov 2002 18:00:52 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may be able to help you narrow it down a bit. I have used 2.4.19-vanilla 
and it worked fine(all drives showed up). When I tried 
fnk10(www.cipherfunk.org) the drive on the secondary channel doesn't show 
up. I don't know exactly what changes fnk10 has with regards to ide, but I 
know he has put a bunch of stuff from the 20-pre series in fnk10. Hope this 
helps. 

 --Brian Jackson 

Justin Cormack writes: 

> On Tue, 2002-11-05 at 19:49, Justin Cormack wrote:
>> I have a Promise Ultra133 IDE controller, and cannot get any drives to
>> appear on the second channel under Linux. The controller says it finds
>> the drive on the second channel on its bios screen, but Linux will not
>> see it. This is with 2.4.20-pre9 and -rc1.
> 
> As a followup, this does not occur with default Redhat 8.0 kernel, so it
> is a problem with the large changes in the driver since 2.4.18. Will try
> to work out exactly when it broke. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
 
