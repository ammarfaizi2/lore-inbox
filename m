Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3WMj>; Thu, 30 Nov 2000 17:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQK3WM3>; Thu, 30 Nov 2000 17:12:29 -0500
Received: from sanrafael.dti2.net ([195.57.112.5]:32269 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S129257AbQK3WMZ>;
	Thu, 30 Nov 2000 17:12:25 -0500
Message-ID: <06c601c05b16$745cf0b0$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20001017000243Z129097-28851+2964@vger.kernel.org> <20001017115350.E9732@garloff.etpnet.phys.tue.nl>
Subject: RE: OnStream DI-30 with ide-tape version 1.16f problems
Date: Thu, 30 Nov 2000 22:42:36 +0100
Organization: DTI2 - Desarrollo de la Tecnología de las Comunicaciones
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I have the same problem, and yes I have a medium inserted. What can I
do?

    Regards.

    -Jorge

P.D.    Debian 2.2 (+ some updates from woody to complaint 2.4 series of
kernels)
            2.4.0.test11 + reiserfs
            Tyan K7 VIA + CMD649
            Same tape drive and same revision of firmware. (primary in the
second channel of the motherboard)

==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
Without wicker a basket cannot be done.
==============================================================

----- Mensaje original -----
De: "Kurt Garloff" <garloff@suse.de>
Para: "Noel Burton-Krahn" <noel@burton-krahn.com>
CC: <andre@suse.com>; <linux-kernel@vger.kernel.org>
Enviado: martes, 17 de octubre de 2000 10:53
Asunto: Re: OnStream DI-30 with ide-tape version 1.16f problems

On Mon, Oct 16, 2000 at 04:51:48PM -0700, Noel Burton-Krahn wrote:
> mt -f /dev/nht0 status
>
>     /dev/nht0: Device or resource busy
>
> tail /var/log/messages
>
>     kernel: ide-tape: hdd <-> ht0: OnStream DI-30 rev 1.08
>     kernel: ide-tape: hdd <-> ht0: 990KBps, 64*32kB buffer, 10208kB
pipeline, 60ms tDSC
>     kernel: ide-tape: ht0: I/O error, pc =  0, key =  2, asc = 3a, ascq =
0

MEDIUM NOT PRESENT.

>     kernel: ide-tape: ht0: drive not ready

Did you insert a medium?

Regards,
--
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
