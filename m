Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263334AbRGNQrs>; Sat, 14 Jul 2001 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263748AbRGNQrj>; Sat, 14 Jul 2001 12:47:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:54770 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263334AbRGNQr0>; Sat, 14 Jul 2001 12:47:26 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010715031815.D6722@weta.f00f.org> 
In-Reply-To: <20010715031815.D6722@weta.f00f.org>  <200107141414.f6EEEjQ05792@ns.caldera.de> 
To: Chris Wedgwood <cw@f00f.org>
Cc: Christoph Hellwig <hch@caldera.de>,
        Gunther Mayer <Gunther.Mayer@t-online.de>, paul@paulbristow.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 14 Jul 2001 17:47:05 +0100
Message-ID: <17573.995129225@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cw@f00f.org said:
>  Linus, please consider applying the following patch. 
> 
> --- linux-2.4.7-pre6/include/linux/malloc.h	Thu Jul 12 03:53:53 2001
> +++ linux-2.4.7-pre6+mallocRIP/include/linux/malloc.h	Thu Jan  1 12:00:00 1970
> @@ -1,5 +0,0 @@
> -#ifndef _LINUX_MALLOC_H
> -#define _LINUX_MALLOC_H
> -
> -#include <linux/slab.h>
> -#endif /* _LINUX_MALLOC_H */


Doing that in the middle of a supposedly stable series, even if it wasn't a 
fundamentally stupid thing to do in the first place, isn't really very 
sensible.

--
dwmw2


