Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRALJyD>; Fri, 12 Jan 2001 04:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130539AbRALJxy>; Fri, 12 Jan 2001 04:53:54 -0500
Received: from mr14.vic-remote.bigpond.net.au ([24.192.1.29]:53215 "EHLO
	mr14.vic-remote.bigpond.net.au") by vger.kernel.org with ESMTP
	id <S129511AbRALJxp>; Fri, 12 Jan 2001 04:53:45 -0500
Message-ID: <000b01c07c7d$fba05980$0201a8c0@vaio>
From: "Robert Lowery" <cangela@bigpond.net.au>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Nathan Thompson" <nate@thebog.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <001801c07bc4$e95ee250$0201a8c0@vaio> <20010111095853.A4442@eliot.thebog.net> <3A5DCB9D.2DAF83AF@mandrakesoft.com>
Subject: Re: ACPI lockup on boot in 2.4.0
Date: Fri, 12 Jan 2001 20:56:48 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank-you for the pointers.

Looking at the ACPI mailing list, it appears that the ACPI code gets stuck
in an infinite loop with many of the VAIO notebooks.  So it:s back to APM
for now

-Robert
----- Original Message -----
From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
To: "Nathan Thompson" <nate@thebog.net>
Cc: "Robert Lowery" <cangela@bigpond.net.au>; <linux-kernel@vger.kernel.org>
Sent: Friday, January 12, 2001 2:05 AM
Subject: Re: ACPI lockup on boot in 2.4.0


> Nathan Thompson wrote:
> >
> > On Thu, Jan 11, 2001 at 10:51:59PM +1100, Robert Lowery wrote:
> >
> > > I compiled it with ACPI compiled as a module and APM not compiled in
at all, but on booting I get the following.
> > > ACPI: System description tables found
> > > ACPI: System description tables loaded
> > >
> > > and then the system locks up..
> >
> > I have a Sony Vaio PCG-F350 that behaves the same way.  I compiled in
> > ACPI (not a module) and never got further than this.  When I enabled APM
> > and disabled ACPI everything started to work.
>
> To get a more verbose failure scenario, grab the ACPI debug version from
> http://developer.intel.com/technology/IAPC/acpi/downloads.htm
>
> Jeff
>
>
> --
> Jeff Garzik       | "You see, in this world there's two kinds of
> Building 1024     |  people, my friend: Those with loaded guns
> MandrakeSoft      |  and those who dig. You dig."  --Blondie
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
