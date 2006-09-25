Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWIYQNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWIYQNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWIYQNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:13:20 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:61890 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S1751076AbWIYQNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:13:19 -0400
Message-ID: <4517FFF4.8060501@cc.jyu.fi>
Date: Mon, 25 Sep 2006 19:12:36 +0300
From: lamikr <lamikr@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Vladimir <vovan888@gmail.com>
CC: tony@atomide.com, OMAP-Linux <linux-omap-open-source@linux.omap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Add gsm phone support for the mixer in tsc2101 alsa
 driver.
References: <44E51565.6020505@cc.jyu.fi> <20060905151808.GC18073@atomide.com>	 <44FF2A6D.3000500@cc.jyu.fi> <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
In-Reply-To: <ce55079f0609250442x5638a93fuac95c65a54a0927@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir wrote:
>> 1) As we do not yet have any kind of multiplexing support to gsm module
>> (currently directly accesing dev/ttyS1 for at commands)
>> our phone app is not able to run simultaneously with the ppp. I am not
>> sure should I resolve this in the kernel space or user space.
>>
>
> I work on getting linux running on Siemens SX1 mobile phone.
> and I use GSM multiplexer daemon from here -
> http://developer.berlios.de/projects/gsmmux/
> it works fine for me.
Have you tried to use pppd over that?
Currently the userspace apps are not in handy enought shape and we need
for example to close the phone app
(http://xanadux.cvs.sourceforge.net/xanadux/gomunicator/)
before establishing gprs connection with pppd.
(http://www.handhelds.org/moin/moin.cgi/hpipaqh6300gprs)

Mika


