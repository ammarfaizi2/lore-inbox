Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSKOVyc>; Fri, 15 Nov 2002 16:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbSKOVyb>; Fri, 15 Nov 2002 16:54:31 -0500
Received: from mail3.efi.com ([192.68.228.90]:12807 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S266774AbSKOVy2>; Fri, 15 Nov 2002 16:54:28 -0500
Message-ID: <3DD56FA0.EA5846E6@efi.com>
Date: Fri, 15 Nov 2002 14:05:20 -0800
From: Kallol Biswas <kallol.biswas@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
References: <ar3op8$f20$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 22:01:13.0264 (UTC) FILETIME=[834D2300:01C28CF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of our embedded motherboards do not have
a serial port. May be I should consider adding ethernet
interface support to kgdb.

Linus Torvalds wrote:

> In article <334960000.1037397999@flay>,
> Martin J. Bligh <mbligh@aracnet.com> wrote:
> >> Is there a source level remote kernel debugger that
> >> communicates over an ethernet interface? The debugger
> >> kgdb from kgdb.sourceforge.net works only with serial port.
> >
> >A cheap terminal server might work ...
>
> Well, apart from the fact that a lot of machines don't even _have_
> serial ports..
>
> I dunno. I might even be willing to apply kgdb patches to my tree if it
> just could use the regular network card I already have connected on all
> my machines. None of my laptops have a serial line, for example, but
> they all have networking.
>
> Soon even _desktops_ probably won't have serial lines any more, only
> USB.
>
>                 Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

