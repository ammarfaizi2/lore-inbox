Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbQLaBPx>; Sat, 30 Dec 2000 20:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132103AbQLaBPo>; Sat, 30 Dec 2000 20:15:44 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:4224 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S135521AbQLaBPd>;
	Sat, 30 Dec 2000 20:15:33 -0500
Message-ID: <3A4E8190.DA4CB916@pobox.com>
Date: Sat, 30 Dec 2000 16:45:04 -0800
From: J Sloan <jjs@pobox.com>
Organization: Mirai Consulting
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13-pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

> It haven't loaded since test13-pre1 for me.
> Only the 'module version' was broken.
> Last test12-pre7 was fine, here.
> It was introduced with the Makefile cleanups.
>
>  --- linux/drivers/char/drm/drmP.old        Thu Dec 28 16:27:34 2000
>  +++ linux/drivers/char/drm/drmP.h        Sat Dec 23 13:57:08 2000
>  @@ -40,6 +40,7 @@
>   #include <asm/current.h>
>   #endif /* __alpha__ */
>   #include <linux/config.h>
>  +#include <linux/modversions.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/miscdevice.h>

I just want to confirm that this small fix solves my drm
problems as well - currently running -test13-pre7

Er, has anybody sent a patch to the maintainers?

jjs




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
