Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbRBKRSI>; Sun, 11 Feb 2001 12:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbRBKRR6>; Sun, 11 Feb 2001 12:17:58 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:17570 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129441AbRBKRRp>; Sun, 11 Feb 2001 12:17:45 -0500
Message-ID: <3A86C921.B5883004@wanadoo.fr>
Date: Sun, 11 Feb 2001 18:17:21 +0100
From: Jean-luc Coulon <jean-luc.coulon@wanadoo.fr>
Organization: personal system
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.19pre9 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Leo Laursen <l.laursen@mail1.stofanet.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Power off 2.4.xx and ACPI / APM
In-Reply-To: <3a86a5043affcc88@alisier.wanadoo.fr> (added by alisier.wanadoo.fr)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leo Laursen wrote:

> I artikel <3A868CFE.858E50FC@wanadoo.fr>, skrev "Jean-luc Coulon"
> <jean-luc.coulon@wanadoo.fr>:
>
> >> Does this ACPI problem occur with 2.4.2-pre3?  (patch available from
> >> ftp://ftp.fr.kernel.org/pub/linux/kernel/testing/)
> >>
> >
> > Yep! The same problem with all the 2.4.x  and 2.4.x-prey.
> >
> > CONFIG_APM=m
>
> I am not on the list, but follows the discassion via news
>
> I believe the APM module is unloaded before it can shutdown
> so CONFIG_APM=y might work (works for me )
> Leo

Bingo !
At least, "power off" works with APM "Y" ... this does not solve the ACPI
/and AX25 related problem.
With 2.2x, you have not the choice : APM is "Y/N", it is not possible to
install it as a module.

----

Thank you, best regards

        Jean-Luc



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
