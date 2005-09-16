Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVIPFWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVIPFWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 01:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVIPFWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 01:22:35 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:19176 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751234AbVIPFWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 01:22:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QqnAZD7SDhTRApKF+/Jzm7wPxvbQips06Wit1TV1v68zpC4ut0uofeOie5PJCQc1mw1/0xjkDZH5dkznmr0/ZIuJr8ylKZx8pjtioUZm4JZ44xIfCCj9OSHECEr6IwwNMLoddXYBdt4BK4ZtnKYtat2S1UGrTQvwvCgNLJ6ywOQ=
Message-ID: <432A548F.80504@gmail.com>
Date: Fri, 16 Sep 2005 00:13:51 -0500
From: Tim Rupp <caphrim007@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
References: <432A4A1F.3040308@gmail.com> <200509152357.58921.dtor_core@ameritech.net>
In-Reply-To: <200509152357.58921.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Thursday 15 September 2005 23:29, Tim Rupp wrote:
> 
>>I just recently went to upgrade to 2.6.13 from 2.6.12.3 and after
>>re-compiling with a clean .config, I've hit a snag.
>>
>>I'm pretty sure I've got the config script down right, but upon reboot,
>>I no longer have a keyboard.
>>
>>I checked to see if this had crept up between 2.6.12.3 and 2.6.13.1. It
>>seems that >2.6.13 are the versions that do this.
>>
>>Attached are dmesgs from my 2.6.13.1 and 2.6.12.3 kernels. In the
>>2.6.13.1 kernel I noticed this line.
>>
>>	i8042.c: Can't read CTR while initializing i8042
>>
> 
> 
> The kernel failed to talk to your keyboard controller. Try booting with
> "usb-handoff" and also try "acpi=off"
> 

Excellent, either argument gets me my keyboard back, thanks a ton Dmitry!

Tim
