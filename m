Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262666AbSJEVSb>; Sat, 5 Oct 2002 17:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSJEVSb>; Sat, 5 Oct 2002 17:18:31 -0400
Received: from zf1.sntcanada.com ([206.49.67.178]:5505 "HELO zf1.sntcanada.com")
	by vger.kernel.org with SMTP id <S262666AbSJEVSa>;
	Sat, 5 Oct 2002 17:18:30 -0400
Message-ID: <03ee01c26cb5$83dd1620$1401010a@icccuba.com>
From: "Maykel Moya" <mike@icc-cuba.com>
To: <linux-kernel@vger.kernel.org>
Subject: Asus CUV4X crashed at boot
Date: Sat, 5 Oct 2002 17:23:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Searching through archives founded problems respect to CUV4X-* mainboards
booting 2.4.x kernels. The messages I did found are about mid 2001, where 2.4.3
was in the throne.

I have an Asus CUV4X board, my linux crash while booting, tested with 2.4.19 and
2.4.20-pre8. Taking the advise from those all messages I booted with 'noapic'
but then my second NIC wheren't not correctly. initialized.

I think although noapic "ensures" booting, probably introduces later problems.

<copy from="ancient_message">
On Tue, Apr 03, 2001 at 10:40:36AM +1200, Simon Garner wrote
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
>
> > > I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> > > 2.4.2 (debian woody). In addition, the kernel would sometimes hang
> > > around NMI watchdog enable. At least, I think it's trying to
> >
> > Known problem. Thats one reason why -ac trees had nmi watchdog turned off.
>
> It still crashes with nmi_watchdog turned off.
>
> Running with noapic fixes it but then the system crashes if you access the
> RTC with hwclock (and probably creates a hundred other problems...).
>
> How can I get this chipset/motherboard supported properly under Linux? I'm
> happy to test patches etc. on the box. *pleading*

Patience is likely to be effective. The chipset isn't exactly rare
being on SMP boards from Gigabyte, MSI, Tyan and Asus, and likely
others. I'm betting it will be fixed soon enough. UP and 2.2.x
kernels worked fine here if you're really desperate. OTOH, the
board is stable once you get past the boot problems... What sort
of production system needs frequent unattended boots?

Sorry about this, I just don't remember signing any paychecks for
what I know is likely to be a non-issue probably before the next
time I actually have to do something drastic, like reboo
</copy>

I would like to know if anyone is enduring this problem and if it's currently
addressed on -ac tree.

My system (Asus CUV4X, 2.4.19 or 2.4.20-pre8, UP P3 600MHz)

Regards,
Maykel Moya


