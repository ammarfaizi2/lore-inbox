Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVJZNga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVJZNga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVJZNga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:36:30 -0400
Received: from bno-84-242-95-171.nat.karneval.cz ([84.242.95.171]:29595 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932544AbVJZNg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:36:29 -0400
Message-ID: <435F8677.4080201@gmail.com>
Date: Wed, 26 Oct 2005 15:36:55 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Florian Engelhardt <flo@dotbox.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5-mm1 wont compile
References: <1130304672.435f14a0819ca@www.domainfactory-webmail.de>
In-Reply-To: <1130304672.435f14a0819ca@www.domainfactory-webmail.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Engelhardt napsal(a):
> Hello,
> 
> i patched the vanilla 2.6.13 with the 2.6.14-rc5 patch
> and after that with the 2.6.14-rc5-mm1 patch, configured the
> kernel and executed make:
> 
>   CC      net/core/filter.o
> In file included from include/net/request_sock.h:22,
>                  from include/linux/ip.h:84,
>                  from include/net/ip.h:28,
>                  from net/core/filter.c:28:
> include/net/sock.h: In function `sk_dst_get':
> include/net/sock.h:972: warning: implicit declaration of function
> `__raw_read_unlock'
> include/net/sock.h: In function `sk_dst_set':
> include/net/sock.h:991: warning: implicit declaration of function
> `__raw_write_unlock'
>   CC      net/core/net-sysfs.o
> In file included from net/core/net-sysfs.c:16:
> include/net/sock.h: In function `sk_dst_get':
> include/net/sock.h:972: warning: implicit declaration of function
> `__raw_read_unlock'
> include/net/sock.h: In function `sk_dst_set':
> include/net/sock.h:991: warning: implicit declaration of function
> `__raw_write_unlock'
>   LD      net/core/built-in.o
>   CC      net/ethernet/eth.o
> In file included from include/net/request_sock.h:22,
>                  from include/linux/ip.h:84,
>                  from net/ethernet/eth.c:49:
> include/net/sock.h: In function `sk_dst_get':
> include/net/sock.h:972: warning: implicit declaration of function
> `__raw_read_unlock'
> include/net/sock.h: In function `sk_dst_set':
> include/net/sock.h:991: warning: implicit declaration of function
> `__raw_write_unlock'
>   CC      net/ethernet/sysctl_net_ether.o
>   LD      net/ethernet/built-in.o
>   CC      net/ipv4/route.o
> In file included from include/linux/mroute.h:129,
>                  from net/ipv4/route.c:89:
> include/net/sock.h: In function `sk_dst_get':
> include/net/sock.h:972: warning: implicit declaration of function
> `__raw_read_unlock'
> include/net/sock.h: In function `sk_dst_set':
> include/net/sock.h:991: warning: implicit declaration of function
> `__raw_write_unlock'
> net/ipv4/route.c: In function `rt_check_expire':
> net/ipv4/route.c:663: warning: dereferencing `void *' pointer
> net/ipv4/route.c:663: error: request for member `raw_lock' in something not a
> structure or union
> make[2]: *** [net/ipv4/route.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
.config please

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
