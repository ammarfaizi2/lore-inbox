Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUFRDbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUFRDbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 23:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUFRDbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 23:31:24 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:5304 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264977AbUFRDbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 23:31:22 -0400
Date: Thu, 17 Jun 2004 21:20:57 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Programtically tell diff between HT and real
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <009101c454e3$45cd0530$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.dpf28q3.1t6gfg5@ifi.uio.no> <fa.frt3cgc.l145hu@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If that 2.8 GHz CPU is not 800 MHz FSB, then it's not HT-capable regardless
of what the feature flags say (as far as I know, most P4 CPUs show HT
support in the feature flags even if it doesn't really support it).


----- Original Message ----- 
From: "Richard B. Johnson" <root@chaos.analogic.com>
Newsgroups: fa.linux.kernel
To: "Andre Tomt" <andre@tomt.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, June 16, 2004 4:02 PM
Subject: Re: Programtically tell diff between HT and real


> On Wed, 16 Jun 2004, Andre Tomt wrote:
>
> > Richard B. Johnson wrote:
> > > flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> > >   mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
cid
> > >                                                            ^_______
> > > bogomips : 5570.56
> > >
> > > I would love to know how you turn in on! This is one of those
> > > "latest-and-greatest" Intel D865PERL mother-boards and I've
> > > even flashed the BIOS with the "latest-and-greatest".
> >
> > The usual way is to enable HT in BIOS, and use a SMP enabled kernel.
> >
>
> It's a SMP kernel. There is no 'HT enable' in the BIOS setup.
> In fact, there is very little that can be set and, it's even
> very hard to convince it that I want to boot from a SCSI and
> not from the first disk it finds. One has to remove the battery
> to discharge the CMOS so it won't ignore the 'Del' key
> on startup. It's a very bad BIOS or a very bad board, I
> don't know which.
>
>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

