Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291628AbSBAJV1>; Fri, 1 Feb 2002 04:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBAJU5>; Fri, 1 Feb 2002 04:20:57 -0500
Received: from Expansa.sns.it ([192.167.206.189]:30988 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S291629AbSBAJTz>;
	Fri, 1 Feb 2002 04:19:55 -0500
Date: Fri, 1 Feb 2002 10:19:53 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Patrick Mochel <mochel@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 does not compile on sparc64
In-Reply-To: <Pine.LNX.4.33.0201310930130.800-100000@segfault.osdlab.org>
Message-ID: <Pine.LNX.4.44.0202011019130.25956-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it does compile.
Thanx

I applied also David's patch, I am quite ready to reboot ;)


On Thu, 31 Jan 2002, Patrick Mochel wrote:

>
>
> On Thu, 31 Jan 2002, Luigi Genoni wrote:
>
> > Yes, but the error do persist also with this patch,
> > probably my english was unclear.
> > I changes the include, because otherway I was getting
> > a no such file message, after the change I got this error
> > message.
> > I should add that gcc for sparc64 to compile a 64 bit kernel is just egcs
> > 1.1.2, because gcc 2.95 and following have problems to compile at 64 bit
> > of sparc.
>
> Ah, I see.
>
> So, you're getting this error:
>
> core.c:179: parse error before `device_init_root'
> core.c:180: warning: return-type defaults to `int'
> core.c:185: parse error before `device_driver_init'
> core.c:186: warning: return-type defaults to `int'
>
> If you add
>
> #include <linux/init.h>
>
> does it compile?
>
> 	-pat
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

