Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbRGNOPx>; Sat, 14 Jul 2001 10:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbRGNOPn>; Sat, 14 Jul 2001 10:15:43 -0400
Received: from ns.caldera.de ([212.34.180.1]:53227 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267642AbRGNOPd>;
	Sat, 14 Jul 2001 10:15:33 -0400
Date: Sat, 14 Jul 2001 16:14:45 +0200
Message-Id: <200107141414.f6EEEjQ05792@ns.caldera.de>
From: hch@caldera.de (Christoph Hellwig)
To: Gunther.Mayer@t-online.de (Gunther Mayer)
Cc: paul@paulbristow.net, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3B50213B.A826C259@t-online.de>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gunter,

In article <3B50213B.A826C259@t-online.de> you wrote:
> @@ -45,7 +63,7 @@
>  #include <linux/major.h>
>  #include <linux/errno.h>
>  #include <linux/genhd.h>
> -#include <linux/slab.h>
> +#include <linux/malloc.h>
>  #include <linux/cdrom.h>
>  #include <linux/ide.h>

Why doe people reverse Jeff's s/malloc.h/slab.h/ changes all
the time.  Malloc.h does nothing but including slab.h and should
just die.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
