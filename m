Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSKRRoK>; Mon, 18 Nov 2002 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSKRRoK>; Mon, 18 Nov 2002 12:44:10 -0500
Received: from descript.sysdoor.net ([81.91.66.78]:21267 "EHLO jenna")
	by vger.kernel.org with ESMTP id <S263991AbSKRRoI>;
	Mon, 18 Nov 2002 12:44:08 -0500
Message-ID: <001901c28f2b$2f3540a0$76405b51@romain>
From: "Vergoz Michael" <mvergoz@sysdoor.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Ducrot Bruno" <poup@poupinou.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <20021118170447.GB27595@poup.poupinou.org> <3DD9227E.5030204@pobox.com>
Subject: Re: 8139too.c patch for kernel 2.4.19
Date: Mon, 18 Nov 2002 18:51:55 +0100
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

Hi list,

The driver that i have post support realtek 8139A/B/C/D/C+ (already tested)
and another dlink card (realtek based).
On certain motherboard where the chip is integred you will perhaps have some
troubles.

The driver 8139cp.c can be removed to the source entry.

I think it's the better way to removed it, but i'm not a linux kernel
developer to take any type of decisions :P

PS : I'v don't really understand what is the problem with the APIC support
?!

Best regards,
Vergoz Michael

From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Ducrot Bruno" <poup@poupinou.org>
Cc: "Vergoz Michael" <mvergoz@sysdoor.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Monday, November 18, 2002 6:25 PM
Subject: Re: 8139too.c patch for kernel 2.4.19


> Ducrot Bruno wrote:
>
> > On Mon, Nov 18, 2002 at 09:50:50AM +0100, Vergoz Michael wrote:
> >
> > >Hi Jeff,
> > >
> > >What i see is the current driver _doesn't_ work on my realtek 8139C.
> > >With this one it work fine.
> >
> >
> > The question was (as I understand the changes you made and the
> > answer from Jeff) : did your card work with 8139cp or not?
> >
> > If not, you have to modify 8139cp, which is the right place for C+
> > support.
>
>
>
> Agreed.  However from the above quoted, "8139C" chip would indicate that
> he needs to use 8139too not 8139cp.
>
> I am hoping (please!) that Michael will post some info that will help us
> debug his problem.
>
> Regards,
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

