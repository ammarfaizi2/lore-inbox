Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSEMNHB>; Mon, 13 May 2002 09:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSEMNHA>; Mon, 13 May 2002 09:07:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17168 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313163AbSEMNHA>; Mon, 13 May 2002 09:07:00 -0400
Message-ID: <3CDFABAC.3020802@evision-ventures.com>
Date: Mon, 13 May 2002 14:03:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pdc202xx.c fails to compile in 2.5.15
In-Reply-To: <5.1.1.2.2.20020513144903.02885310@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Franz Sirl napisa?:
> Alan Cox wrote:
> 
>> > Because of there are apparently devices on which you must check 
>> device class
>> > (2.5.14 talks about CY82C693 and IT8172G), I'll leave proper fix on 
>> Martin,
>> > but simple fix below work fine on my Asus A7V.
>>
>> You need to do specific checks for the device in question. Removing the
>> class check btw is something anyone reading this message should not do
>> even in the same situation unless they know precisely what other
>> mass storage class devices they have present. You can easily trash a
>> raid array otherwise
> 
> 
> I think you are probably talking about the class check for unknown 
> devices a few lines above in 2.5.15. Removing the class check when a 
> driver already claimed responsibility just reinstates what we had in 
> 2.4. The removal is in IDE 61.

Witht the exception that there are not proper vendor id cheks in
2.4 there. Oh well...

