Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317871AbSGPPz7>; Tue, 16 Jul 2002 11:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSGPPz6>; Tue, 16 Jul 2002 11:55:58 -0400
Received: from dsl-65-188-251-69.telocity.com ([65.188.251.69]:35990 "EHLO
	orr.homenet") by vger.kernel.org with ESMTP id <S317871AbSGPPz6>;
	Tue, 16 Jul 2002 11:55:58 -0400
From: "Jason Lunz" <lunz@reflexsecurity.com>
To: zhengcb@netpower.com.cn, lunz@falooley.org
Cc: linux-kernel@vger.kernel.org
Message-Id: <slrnaj8b8s.p4m.lunz@stoli.localnet>
Subject: Re: how to improve the throughput of linux network
References: <200207160915391.SM00792@zhengcb>
Date: Tue, 16 Jul 2002 10:26:37 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zhengcb@netpower.com.cn said:
> we use linux as our router. i just tested the performance of the
> router with smartbits, and i found that the throughput of 64byte frame
> is only 25%, about 35kpps. 
>
> someone mentioned that the throughput of 64byte frame could reach
> 70kpps.so i wish i could improve the performance of our router,but i
> don't know how to do that.
>
> i looked for some solution, and found some article mentioned the NAPI.
> it changed the driver to polling mode,so that the interrupt is no too
> much. but i could not find  drivers for our router.(eepro100 card).
> has the polling mode driver been used in linux?

I made NAPI core and driver patches for linux 2.4; they're at
http://gtf.org/lunz/linux/net/. There's an eepro100 driver there.

Please send me (and the linux netdev list) the results of any testing
you do.

Jason
