Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSKKNSs>; Mon, 11 Nov 2002 08:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSKKNSs>; Mon, 11 Nov 2002 08:18:48 -0500
Received: from fe6.rdc-kc.rr.com ([24.94.163.53]:48914 "EHLO mail6.kc.rr.com")
	by vger.kernel.org with ESMTP id <S265012AbSKKNSs>;
	Mon, 11 Nov 2002 08:18:48 -0500
Date: Mon, 11 Nov 2002 07:26:06 -0600 (CST)
From: Ognen Duzlevski <ognen@kc.rr.com>
X-X-Sender: ognen@gemelli.dyndns.org
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47 ipv4 netfilter compile time error
In-Reply-To: <1036990568.24251.4.camel@flat41>
Message-ID: <Pine.LNX.4.44.0211110725360.707-100000@gemelli.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a patch for this for 2.5.45 and 2.5.46, one would think it would
get fixed eventually...

Ognen

On 11 Nov 2002, Grzegorz Jaskiewicz wrote:

> Hello !
>
>
> i've discovered this error during compilation:
>
> net/ipv4/netfilter/ipt_TCPMSS.c: In function `ipt_tcpmss_target':
> net/ipv4/netfilter/ipt_TCPMSS.c:95: structure has no member named `pmtu'
> make[3]: *** [net/ipv4/netfilter/ipt_TCPMSS.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
>
> on demand i'll include .config
>
> now i will switch off this one, and try to compile it without netfilter.
> It is still impossilble to make saa7146 module too...
>
> anyway, keep doing this good job folks.
>
> --
> Greg Iaskievitch

