Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaBiw>; Sat, 30 Dec 2000 20:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135627AbQLaBim>; Sat, 30 Dec 2000 20:38:42 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:10794 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S130643AbQLaBij>; Sat, 30 Dec 2000 20:38:39 -0500
Message-ID: <3A4E86DF.777B0A1E@xmission.com>
Date: Sat, 30 Dec 2000 18:07:43 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: J Sloan <jjs@pobox.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tdfx.o and -test13
In-Reply-To: <E14CWw1-0007GV-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > >  +#include <linux/modversions.h>
> > >   #include <linux/module.h>
> > >   #include <linux/kernel.h>
> > >   #include <linux/miscdevice.h>
> >
> > I just want to confirm that this small fix solves my drm
> > problems as well - currently running -test13-pre7
> >
> > Er, has anybody sent a patch to the maintainers?
>
> Wrong patch. Modversions.h should be getting automatically included. That
> is what needs fixing. You've nicely located the problem and fixed the symptoms
> for the module versioned case

This "patch" apparently has been around since test13-pre1. I guess the
maintainers are on vacation.

Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
