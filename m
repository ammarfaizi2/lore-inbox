Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130502AbRCLR0z>; Mon, 12 Mar 2001 12:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130505AbRCLR0q>; Mon, 12 Mar 2001 12:26:46 -0500
Received: from smtp1.sentex.ca ([199.212.134.4]:27916 "EHLO smtp1.sentex.ca")
	by vger.kernel.org with ESMTP id <S130502AbRCLR0h>;
	Mon, 12 Mar 2001 12:26:37 -0500
Message-ID: <3AAD055C.A5300E9E@coplanar.net>
Date: Mon, 12 Mar 2001 12:20:28 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Pozsar Balazs <pozsy@sch.bme.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Ide Hot-swaping?
In-Reply-To: <Pine.GSO.4.30.0103121717480.11985-100000@balu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsar Balazs wrote:

> Is it possible to hot-swap ide drives and re-detect them?
> Does 'normal' Pc-hardware allow it?

read a recent man page for hdparm and you will see kernel
allows remove/add ide interface.  scripts with correct
parameter usage are in contrib directory of hdparm source.
IDE maintainer has code to electrically turn off (tristate)
ide channels on most PC ide chips, but is waiting to
demonstrate at an industry conference before releasing
to public.

>
>
> thanks,
> Balazs Pozsar.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

