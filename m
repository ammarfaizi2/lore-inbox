Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284472AbRLIV6Z>; Sun, 9 Dec 2001 16:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284517AbRLIV6L>; Sun, 9 Dec 2001 16:58:11 -0500
Received: from Aniela.EU.ORG ([194.102.102.235]:13321 "EHLO NS1.Aniela.EU.ORG")
	by vger.kernel.org with ESMTP id <S284488AbRLIV5s>;
	Sun, 9 Dec 2001 16:57:48 -0500
Date: Sun, 9 Dec 2001 23:57:40 +0200 (EET)
From: <lk@Aniela.EU.ORG>
To: <linux-kernel@pogrammers-world.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols (NOT A BUG)
In-Reply-To: <002e01c180e4$f6568a50$0328a8c0@keasanb>
Message-ID: <Pine.LNX.4.33.0112092356340.10961-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




You know you could try to use ULOGD target. It's easier to hack that than
the kernel.

bye


On Sun, 9 Dec 2001, Sascha Andres wrote:

> hi,
>
> i try to add syslog support into net/ipv4/netfilter/ipt_LOG.c .
> so i added  an include to sys/syslog.h and used the functions
> in there.
>
> i now get unresolved symbols for each function i use from syslog.h .
>
> my question is, must i merge the whole syslog code to the kernel
> for being able to use syslog in the above mentioned mod?
>
> i added a 'firewall' facility to syslog and want all netfilter
> logs coming throuh ipt_LOG log to this facility.
>
> sorry if this sounds 'strange', but i'm relative new to the kernel
> sources.
>
> i started this cause i have not seen a possibility to log to
> a specific facility with the klog daemon.
>
> bye,
>
> sascha
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

