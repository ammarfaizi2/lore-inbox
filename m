Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264834AbSJVT4X>; Tue, 22 Oct 2002 15:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264837AbSJVT4W>; Tue, 22 Oct 2002 15:56:22 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58554 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264834AbSJVT4R>; Tue, 22 Oct 2002 15:56:17 -0400
Subject: Re: Problem compiling 2.5.44 (net/ipv4/raw.c)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Juan M. de la Torre" <jmtorre@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021022184920.GA8742@apocalipsis>
References: <20021022184920.GA8742@apocalipsis>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 21:18:41 +0100
Message-Id: <1035317921.31979.137.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 19:49, Juan M. de la Torre wrote:
> 
>   net/ipv4/raw.c: In function `raw_send_hdrinc':
>   net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
>   function)
>   net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
>   net/ipv4/raw.c:297: for each function it appears in.)
>   make[2]: *** [net/ipv4/raw.o] Error 1
>   make[1]: *** [net/ipv4] Error 2
>   make: *** [net] Error 2
> 
>  net/ipv4/raw.c includes linux/netfilter.h, but not linux/netfilter_ipv4.h
>  (NF_IP_LOCAL_OUT is defined in netfilter_ipv4.h).

Fixed in -ac1 - you can just grab the net/ipv4/raw.c fix if need be

