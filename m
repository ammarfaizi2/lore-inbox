Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVBRUE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVBRUE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVBRUE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:04:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:47770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261470AbVBRUDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:03:52 -0500
Message-ID: <42164A27.8010402@osdl.org>
Date: Fri, 18 Feb 2005 12:03:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 current BK] Unnecesary code gets compiled in during build?
References: <132340039.20050218204824@dns.toxicfilms.tv>
In-Reply-To: <132340039.20050218204824@dns.toxicfilms.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak wrote:
> Hi,
> 
> I am compiling 2.6.11-rc4-cset
> 
> And I see during the compilation:
>   LD      drivers/media/common/built-in.o
>   LD      drivers/media/dvb/b2c2/built-in.o
>   LD      drivers/media/dvb/bt8xx/built-in.o
>   LD      drivers/media/dvb/cinergyT2/built-in.o
>   LD      drivers/media/dvb/dibusb/built-in.o
>   LD      drivers/media/dvb/dvb-core/built-in.o
>   LD      drivers/media/dvb/frontends/built-in.o
>   LD      drivers/media/dvb/ttpci/built-in.o
>   LD      drivers/media/dvb/ttusb-budget/built-in.o
>   LD      drivers/media/dvb/ttusb-dec/built-in.o
>   LD      drivers/media/dvb/built-in.o
>   LD      drivers/media/radio/built-in.o
>   LD      drivers/media/video/built-in.o
> 
> Although I know I have not added dvb, nor radio.
> How come this shows up?

It makes the kbuild system easier ?

It's probably fixable (I haven't looked), but I have
noticed the same thing that you are seeing.
Patches are welcome... if it needs to be fixed.

Did you notice how large those built-in.o files are?

> I am attaching my .config, it does not have DVB set.

-- 
~Randy
