Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJSTYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTJSTYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:24:44 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:48257 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262182AbTJSTYm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:24:42 -0400
Message-ID: <013801c39677$035e1d40$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>    <1066579176.7363.3.camel@milo.comcast.net><41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>    <yw1x3cdpgm46.fsf@users.sourceforge.net> <48232.192.168.9.10.1066590873.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 21:27:19 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomy,

The

hdparm -m0 device

seems to have fixed the problem for me. I'll try increasing the number in
the following days and run extensive tests, but for now, it's quite enough.

BTW your email server doesn't seem to like my address and refuses to deliver
any mail, if you aren't running it maybe you should tell the admin that he's
blocking Spain's largest ISP for some reason?


----- Original Message ----- 
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Måns Rullgård" <mru@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, October 19, 2003 21:14
Subject: Re: HighPoint 374


>
> > "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi> writes:
> >
> >>> In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
> >>> "experimental" IDE Raid with two disks on a HPT 374 controller with
the
> >>> drivers that come with the kernel.
> >>
> >> I have tried these versions in the past as well without success.
> >> However, I don't use HPT-raid features at all ie. I'm using the
> >> disks as JBOD. What hardware do you have and have you enabled
> >> ACPI/local-apic/io-apic ? What brand & model of disk-drives you
> >> are using with HPT374 controller ? And finally what does
> >> the /proc/interrupts show for you ?
> >
> > I'm using a RocketRAID 1540 SATA card (hpt374 based) in an Alpha
> > system.  It has no such thing as ACPI.  The disks are four Seagate
> > Barracuda 7200.7 running software raid5.  My /proc/interrupts:
>
> Ok, that might be one reason why it's working for you but not for me.
> If I've understood correctly, people who have problems with HPT374
> are using the integrated Parallel-ATA interface instead of SATA.
>
> I'd be really interested to hear if anyone has a working system
> with kernel included drivers & HPT374-controller integrated in
> motherboard and using PATA-drives ?
>
> Regards,
> Tomi Orava
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

