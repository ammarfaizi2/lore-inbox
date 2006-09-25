Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWIYRMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWIYRMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIYRMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:12:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46344 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWIYRMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:12:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=FgOPNuP9h3619GDlg1eGEQPEP83KTtuwFyJmf158nhFn3Gqc3UBR2DbQrKxSIPYOfO9coZD1M4BbqOYUXOzQfXaz8pMi+T5q0tr1LeJgqm9VLW542FF+W9z2GiY2bIsnishhBLLbBsaqw/mu9FU+pwyao5Pt/v3u2nX6tSfuWyY=
Date: Mon, 25 Sep 2006 21:19:24 +0400
To: lamikr@cc.jyu.fi
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa driver.
From: Vovan <vovan888@gmail.com>
Cc: tony@atomide.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain; format=flowed; delsp=yes; charset=windows-1251
MIME-Version: 1.0
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com> <44FF2A6D.3000500@cc.jyu.fi> <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com> <4517FFF4.8060501@cc.jyu.fi>
Content-Transfer-Encoding: 8bit
Message-ID: <op.tgf2em02dbah4f@vovan>
In-Reply-To: <4517FFF4.8060501@cc.jyu.fi>
User-Agent: Opera Mail/9.02 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

25.09.06 â 20:12 lamikr wrote:

> Vladimir wrote:
>>> 1) As we do not yet have any kind of multiplexing support to gsm module
>>> (currently directly accesing dev/ttyS1 for at commands)
>>> our phone app is not able to run simultaneously with the ppp. I am not
>>> sure should I resolve this in the kernel space or user space.
>>>
>>
>> I work on getting linux running on Siemens SX1 mobile phone.
>> and I use GSM multiplexer daemon from here -
>> http://developer.berlios.de/projects/gsmmux/
>> it works fine for me.
> Have you tried to use pppd over that?

No, I havn`t tried pppd yet. I am still implementing IPC protocols with  
modem that control sound,battery etc.
But sending plain AT commands works fine.

> Currently the userspace apps are not in handy enought shape and we need
> for example to close the phone app
> (http://xanadux.cvs.sourceforge.net/xanadux/gomunicator/)
> before establishing gprs connection with pppd.
> (http://www.handhelds.org/moin/moin.cgi/hpipaqh6300gprs)

I am still far from such userspace support :)

>
> Mika
>
>


