Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274756AbRJAI3Y>; Mon, 1 Oct 2001 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274757AbRJAI3P>; Mon, 1 Oct 2001 04:29:15 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:48849 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S274756AbRJAI3E>; Mon, 1 Oct 2001 04:29:04 -0400
Date: 01 Oct 2001 09:56:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8A1xnh8mw-B@khms.westfalen.de>
In-Reply-To: <1001907794.19740.1.camel@DESK-2>
Subject: Re: md5sum: WARNING: 4 of 13 computed checksums did NOT match
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <1001907794.19740.1.camel@DESK-2>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhingber@ix.netcom.com (Jeffrey Ingber)  wrote on 30.09.01 in <1001907794.19740.1.camel@DESK-2>:

> 	I receive this warning when compiling 2.4.10.  Maybe it's not
> important, but it caught my attention.
>
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.10/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -DMODULE -DMODVERSIONS -include
> /usr/src/linux-2.4.10/include/linux/modversions.h   -c -o c4.o c4.c
> make[3]: Leaving directory `/usr/src/linux-2.4.10/drivers/isdn/avmb1'
> make -C hisax modules
> md5sum: WARNING: 4 of 13 computed checksums did NOT match

Looks like it's the HiSax certification tester. The HiSax code is  
certified, but that means any change invalidates the certification until  
the guy responsible (Karsten Keil) creates a new PGP-signed md5sum list.

See Documentation/isdn/HiSax.cert.


MfG Kai
