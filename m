Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267139AbUBRCLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 21:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267146AbUBRCLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 21:11:45 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:26941 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S267139AbUBRCLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 21:11:43 -0500
Date: Tue, 17 Feb 2004 20:06:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Cannot enable APIC with 2.6.2
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <028901c3f5c3$d6827e90$6501a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.h8j24i4.smi326@ifi.uio.no> <fa.e1ato89.1dl4vi9@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is not strictly related to ACPI, but many newer systems that support APIC
(and, for Pentium 4 machines, HyperThreading as well) don't export any
"old-style" MP tables that describe the IO APIC (or the HT CPU siblings),
and these can only be detected through ACPI.

Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

----- Original Message ----- 
From: "Tetsuji Rai" <tetsuji_rai@yahoo.com>
Newsgroups: fa.linux.kernel
To: "Mikael Pettersson" <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 17, 2004 6:55 AM
Subject: Re: Cannot enable APIC with 2.6.2


> Mikael Pettersson wrote:
> > ...
> >  > # ACPI (Advanced Configuration and Power Interface) Support
> >  > #
> >  > # CONFIG_ACPI is not set
> >
> > ACPI is disabled. Enable it and try again.
>
> Thank you!  I didn't know APIC is related to ACPI.
>
> -- 
> Tetsuji Rai (in Tokyo) aka AF-One (Athlete's Foot-One)
> Born to be the luckiest guy in the world!   May the Force be with me!
> http://www.geocities.com/tetsuji_rai
> http://setiathome.ssl.berkeley.edu/fcgi-bin/fcgi?cmd=view_feedback&id=1855
> fax: 1-516-706-0320
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

