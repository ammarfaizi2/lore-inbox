Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132498AbQLKB35>; Sun, 10 Dec 2000 20:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbQLKB3s>; Sun, 10 Dec 2000 20:29:48 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:38667 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S132498AbQLKB3h>;
	Sun, 10 Dec 2000 20:29:37 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11
Date: Mon, 11 Dec 2000 09:58:55 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGELMCIAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E144OAg-0003wh-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just applied the said patch and will report my results. Note that I have
never been able to reliably, on-demand reproduce this so give me a few days
to see what happens.

--Rainer


-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, December 08, 2000 11:07 PM
To: David Woodhouse
Cc: Andi Kleen; Rainer Mager; linux-kernel@vger.kernel.org; Mark Vojkovich
Subject: Re: Signal 11


> > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > would say that this is definitely a kernel problem.=20
>
> XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> kernels - even on my BP6=B9. The random crashes started to happen when =
> I
> upgraded my distribution=B2 - and are only seen by people using 2.4. So=
>  I
> suspect that it's the combination of glibc and kernel which is triggeri=
> ng
> it.

Have any of the folks seeing it checked if Ben LaHaise's fixes for the page
table updating race help ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
