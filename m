Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136094AbRD0QmT>; Fri, 27 Apr 2001 12:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136107AbRD0QmJ>; Fri, 27 Apr 2001 12:42:09 -0400
Received: from e145061.upc-e.chello.nl ([213.93.145.61]:53774 "EHLO
	procyon.wilson.nl") by vger.kernel.org with ESMTP
	id <S136094AbRD0Ql5>; Fri, 27 Apr 2001 12:41:57 -0400
From: "Michel Wilson" <michel@procyon14.yi.org>
To: "Jeff Chua" <jeffchua@silk.corp.fedex.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.4-pre8 undefined symbols
Date: Fri, 27 Apr 2001 18:41:47 +0200
Message-ID: <NEBBLEJBILPLHPBNEEHIEEPICDAA.michel@procyon14.yi.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.33.0104280009070.1344-100000@boston.corp.fedex.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Andrea's rwsem-patches fix these, but i'm not sure. You might give
it a try, though.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jeff Chua
> Sent: Friday, April 27, 2001 18:11
> To: Linux Kernel
> Cc: Jeff Chua
> Subject: 2.4.4-pre8 undefined symbols
>
>
>
> depmod -ae yields the following errors under 2.4.4-pre8
>
> Any fix?
>
>
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/drivers/char/drm/i810.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/drivers/char/drm/mga.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/drivers/char/drm/r128.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/drivers/char/drm/radeon.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/drivers/char/drm/tdfx.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.4-pre8/kernel/fs/binfmt_aout.o
> depmod:         rwsem_down_write_failed
> depmod:         rwsem_wake
>
>
>
> Thanks,
> Jeff
> [ jchua@fedex.com ]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

