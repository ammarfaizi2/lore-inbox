Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275256AbRIZPXV>; Wed, 26 Sep 2001 11:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRIZPXM>; Wed, 26 Sep 2001 11:23:12 -0400
Received: from oe23.pav1.hotmail.com ([64.4.30.80]:51207 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275256AbRIZPW4>;
	Wed, 26 Sep 2001 11:22:56 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann1@hotmail.com>
To: "Juan" <piernas@ditec.um.es>, "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <3BB0F483.69929A79@ditec.um.es>
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
Date: Wed, 26 Sep 2001 11:23:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Message-ID: <OE23nHAaaz7EjQxzmWe0000414d@hotmail.com>
X-OriginalArrivalTime: 26 Sep 2001 15:23:17.0381 (UTC) FILETIME=[2ABC4350:01C1469F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same thing.  I have perfect behavior with the stock RedHat 7.2
kernel.

Dan

----- Original Message -----
From: "Juan" <piernas@ditec.um.es>
To: "kernel list" <linux-kernel@vger.kernel.org>
Sent: Tuesday, September 25, 2001 5:17 PM
Subject: Bad, bad, bad VM behaviour in 2.4.10


Hi!

My test is very simple. I have started X-Window and XMMS in order to
listen to some songs. Then, I have executed

dd if=/dev/hdc1 of=/dev/null

as root within a terminal, and I have got the following a few seconds
later:

Sep 25 22:05:55 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:00 localhost last message repeated 2 times
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:00 localhost last message repeated 2 times
Sep 25 22:06:00 localhost kernel: VM: killing process xmms
Sep 25 22:06:00 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 11 times
Sep 25 22:06:04 localhost kernel: VM: killing process xmms
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost kernel: VM: killing process kmix
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 2 times
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:04 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:04 localhost last message repeated 3 times
Sep 25 22:06:04 localhost kernel: VM: killing process gpm
Sep 25 22:06:05 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:06 localhost last message repeated 6 times
sep 25 22:06:06 localhost su(pam_unix)[2548]: session closed for user
root
Sep 25 22:06:06 localhost kernel: VM: killing process sendmail
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process konsole
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process named
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process xmms
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost last message repeated 3 times
Sep 25 22:06:07 localhost kernel: VM: killing process ksmserver
Sep 25 22:06:07 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:07 localhost kernel: VM: killing process kdeinit
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: VM: killing process X
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0xf0/0) from c012ff60
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
f60
Sep 25 22:06:08 localhost last message repeated 2 times
Sep 25 22:06:08 localhost kernel: VM: killing process kdeinit
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:08 localhost kernel: VM: killing process startkde
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60
Sep 25 22:06:09 localhost kernel: VM: killing process named
Sep 25 22:06:09 localhost kernel: __alloc_pages: 0-order allocation
failed (gfp=0x1d2/0) from c012ff60

The /dev/hdc1 partition capacity is 6 GB. My root partition is on
/dev/hda5. My computer is a Pentium III with 384 MB of RAM.

BTW, the same test in 2.4.6 works fine without any problem.

Regards.


--
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

