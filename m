Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTATQgi>; Mon, 20 Jan 2003 11:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTATQgi>; Mon, 20 Jan 2003 11:36:38 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:47513 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266274AbTATQgg>; Mon, 20 Jan 2003 11:36:36 -0500
Reply-to: Wolfgang Fritz <wolfgang.fritz@gmx.net>
To: linux-kernel@vger.kernel.org
From: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Subject: Re: swsuspend: possible with VIA Eden processor? Or alternatives?
Date: Mon, 20 Jan 2003 17:06:51 +0100
Organization: None
Message-ID: <b0h6qr$hqs$1@fritz38552.news.dfncis.de>
References: <b0c20t$rt$1@fritz38552.news.dfncis.de> <20030120125100.GA27330@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en, de-de, de
In-Reply-To: <20030120125100.GA27330@codemonkey.org.uk>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.17; host: gurke)
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.7; AVE: 6.17.0.2; VDF: 6.17.0.17; host: gurke)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Jan 18, 2003 at 06:14:04PM +0100, Wolfgang Fritz wrote:
>  > Hi,
>  > 
>  > the swsuspend mini howto says that a processor with pse/pse36 feature is 
>  > required for swsupend in 2.4.
>  > 
>  > So I am obviously out of luck with 2.4 kernels, but what about 2.5 (the 
>  > mini-howto is silent here)?
> 
>>From include/asm-i386/suspend.h
> 
> static inline void
> arch_prepare_suspend(void)
> {
>     if (!cpu_has_pse)
>         panic("pse required");
> }
> 
I assume this is from a 2.5 kernel (I have no source tree available 
here). I'll check that tomorrow in the office.

> There's really no requirement that you *need* PSE to be able to
> do suspend, but it seems no-one has stepped forward to write the
> necessary code to support non-PSE afaics.
>
I don't even know what pse means :-(

Thank you

Wolfgang

> 		Dave
> 


