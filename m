Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVHKSzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVHKSzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVHKSzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 14:55:54 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:34039 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932363AbVHKSzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 14:55:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=X9z4Z/uWd6rkeVKpyDCK69if5x5xrY7oe5s58U/En2DvXTO55X4KyIZFVelZxNmTwcZpeNfpZta30fjmyUVqiKr9mnC9h2CnnhWe80fb3fLmRs6ugsVAcBICgtQDKCX2VoiC/MTTlw7suapWdBrDqipySzhjXA0sIAu8VThaz3Y=
Message-ID: <42FB9F1E.9060302@gmail.com>
Date: Thu, 11 Aug 2005 20:55:26 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
References: <DBFABB80F7FD3143A911F9E6CFD477B004FAE3E7@hqemmail02.nvidia.com>	 <20050811070943.GB8025@vega.lgb.hu> <1123765523.32375.10.camel@mindpipe> <42FB6C27.1010408@gmail.com> <42FB88F8.7040807@pobox.com> <42FB8D04.8050006@gmail.com> <42FB8F0D.6060202@pobox.com> <42FB9191.6050602@gmail.com> <42FB99D7.6030403@pobox.com>
In-Reply-To: <42FB99D7.6030403@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Michael Thonke wrote:
>
>> Jeff Garzik schrieb:
>>
>>> Please enable ATA_DEBUG and ATA_VERBOSE_DEBUG, and send me the output.
>>
>>
>>
>> I tried that Jeff, but the base problem is on the low-level..
>
>
>
> There may be a BIOS problem, but there is no problem with the 
> controller using SATA II drives.
>
> Can you boot with another drive, and then send the output requested 
> above?

Sorry, but I can't provide them, because I changed the VIA chipset based 
mainboard against a NForce4 Ultra chipset mainboard.

But on heise.de they also pointed out that it's VIA's bug. Not the 
harddrives one, they have some but this not apply on VIA. Samsung act 
and updated the firmware of their drives for compatibility reasons.

And the work-around is to jumper the hdd as SATA I hdd. The problem was, 
that my system to this time was not bootable with my Samsungs Hd160JJ 
and VIA VT8237. Nos they fix it with a new Chipset the VT8327R...where 
we don't need a work-around.
<http://www.via.com.tw/en/products/chipsets/southbridge/vt8237/>

>
>     Jeff
>
Michael

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



