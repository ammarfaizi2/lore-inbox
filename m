Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRDFH03>; Fri, 6 Apr 2001 03:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRDFH0T>; Fri, 6 Apr 2001 03:26:19 -0400
Received: from pandora.caen.it ([195.223.103.2]:34368 "EHLO caen.it")
	by vger.kernel.org with ESMTP id <S131309AbRDFH0J>;
	Fri, 6 Apr 2001 03:26:09 -0400
From: "Stefano Coluccini" <s.coluccini@caen.it>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
        =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
Cc: "Jeff Garzik" <jgarzik@mandrakesoft.com>,
        "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
        "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: st corruption with 2.4.3-pre4
Date: Fri, 6 Apr 2001 09:29:38 +0200
Message-ID: <NDBBIFIMCKPOADMAJOKMKEPFDAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.05.10104052040410.754-100000@callisto.of.borg>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm still waiting for other reports of st/sym53c8xx on PPC under
> 2.4.x. BTW,
> does it work on other big-endian platforms, like sparc?

I don't know if it is the same problem, but ...
I have a Motorola MVME5100 (PowerPC 750 based CPU) with a mezzanine PCI
based on the sym53c875 chip. I'm using the 2_5 kernel from fmslabs and the
first time I have downloaded the kernel all works fine, while in a
successive update the sym53c8xx driver was changed and my board don't work
anymore. The driver hangs on downloading the SCSI scripts.
I'm not a SCSI driver expert, so I've solved the problem installing the old
version of the driver.
Tom Rini says to me that it happened when he have merged some updates from
the 2_4 tree, so I think my problem is related to the latest updates to the
driver.
I hope this helps you.
Bye.
Stefano.

