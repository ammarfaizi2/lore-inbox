Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269428AbRHGUwU>; Tue, 7 Aug 2001 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269433AbRHGUwK>; Tue, 7 Aug 2001 16:52:10 -0400
Received: from h24-76-51-121.vf.shawcable.net ([24.76.51.121]:940 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S269428AbRHGUwB>; Tue, 7 Aug 2001 16:52:01 -0400
Date: Tue, 7 Aug 2001 13:51:35 -0700
From: Stuart Lynne <sl@fireplug.net>
To: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Message-ID: <20010807135135.J17723@fireplug.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  >>> Lets assume that eth0-eth3 are not initialized at boot time and
>  >>> your init scripts attempt to initialize eth4 ...
> 
> I gather that I misunderstood what you were saying above, so let me
> clarify what I now understand by your comments:
> 
>  1. You are assuming a broken set of init scripts. Specifically,
>     they load the individual modules manually by the name of the
>     module, rather than stating that you wish to initialise a
>     particular interface and letting kmod sort out the correct
>     module.
> 
>     If this is your assumption, then you've created an artificial
>     situation that by its very nature is broken and unreliable.
> 

>  >>> To avoid such problems one probably should add a lot of
>  >>> pre-install parameters in modules.conf.
> 
>  >> What problems?
> 
>  > Described above.
> 
> What KERNEL problems then? I don't see any yet.

So not being able to reliable map ethernet devices to names is a feature
not a bug .... 

It *should* be possible to reliably name devices without having to rely
on order dependant initialization.

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>         www.lineo.com         604-461-7532
