Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWA0RUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWA0RUz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWA0RUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:20:55 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:24103 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbWA0RUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:20:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Fvq60WPe3FksG5S4Wn/7Zoi43dVKdsRR9g01ONbOHDOM/cFKZ/omFHSSNwL+o3rynVTtAzgkpRL5WBGAyJwaZrMu7xKymIduBqWfy7AQcqcmQXNE3o2c0IJNAzVWr+b0SG7E9TfA03BaFbTA0tkUS5NfaBrbEJ79QqMZ+6cvTDM=
Message-ID: <43DA5681.2020305@gmail.com>
Date: Sat, 28 Jan 2006 01:21:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Hai Zaar <haizaar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: vesa fb is slow on 2.6.15.1
References: <cfb54190601260620l5848ba3ai9d7e06c41d98c362@mail.gmail.com>	 <43D8E1EE.3040302@gmail.com>	 <cfb54190601260806h7199d7aej79139140d145d592@mail.gmail.com>	 <43D94764.3040303@gmail.com>	 <cfb54190601261610o1479b8fdsbedb0ca96b14b6@mail.gmail.com>	 <43D9B77E.6080003@gmail.com> <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>
In-Reply-To: <cfb54190601270832x29681873i624818603d5db26e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai Zaar wrote:
>>> But anyway, do you have a clue why do I still get this error?
>>> PCI: Failed to allocate mem resource #6:20000@f8000000 for 0000:40:00.0
>>> I've several workstations with _exactly_ the same hardware. I've tried
>>> two of them - both give the error with 2.6.15.1 (and no errors with
>>> 2.6.11.12).
>> Can you post the entire dmesg?
>>
>> Tony
>>
> 
> Attached.
> 

Looks harmless to me.

Can you check /proc/iomem just to verify if that particular address has
been reserved by the OS.

And, are you experiencing any problems with your nvidia card, ie, are
you able to launch X?

Tony
