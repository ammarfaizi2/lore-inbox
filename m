Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSKRInM>; Mon, 18 Nov 2002 03:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSKRInM>; Mon, 18 Nov 2002 03:43:12 -0500
Received: from descript.sysdoor.net ([81.91.66.78]:40973 "EHLO jenna")
	by vger.kernel.org with ESMTP id <S261663AbSKRInL>;
	Mon, 18 Nov 2002 03:43:11 -0500
Message-ID: <003b01c28edf$9e2b1530$76405b51@romain>
From: "Vergoz Michael" <mvergoz@sysdoor.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com>
Subject: Re: 8139too.c patch for kernel 2.4.19
Date: Mon, 18 Nov 2002 09:50:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

What i see is the current driver _doesn't_ work on my realtek 8139C.
With this one it work fine.

Regards,
Michael

Sent: Monday, November 18, 2002 8:34 AM
Subject: Re: 8139too.c patch for kernel 2.4.19


> Vergoz Michael wrote:
>
> > Hi list,
> >
> > The current 8139too.c linux kernel driver dosn't work.
>
>
> Please be more specific.
>
> > There is the patch for the driver 8139too.c at :
> >
> > http://descript.sysdoor.net/patch/kernel/2.4.19/8139too.c.diff
> >
> > It fix some problems with card mode, new hard detection and new card
> > added.
> >
> > Please read the diff.
>
>
>
> The diff is huge, mostly unnecessary, and backs out obvious bug fixes
> (i.e. it _adds_ bugs).  It removes several PCI IDs, eliminating 8139
> support for some cards.  The "new card" is supported by another driver,
> 8139cp.c.
>
> Please send _specific_ changes and bug fixes.
>
> Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

