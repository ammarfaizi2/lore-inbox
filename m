Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBLLfX>; Mon, 12 Feb 2001 06:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130342AbRBLLfN>; Mon, 12 Feb 2001 06:35:13 -0500
Received: from sanrafael.dti2.net ([195.57.112.5]:9233 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S129094AbRBLLfB>;
	Mon, 12 Feb 2001 06:35:01 -0500
Message-ID: <000b01c094e8$12075d90$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: "Arjan van de Ven" <arjan@fenrus.demon.nl>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <m14SFN4-000OaIC@amadeus.home.nl>
Subject: RE: RAID1 read balancing
Date: Mon, 12 Feb 2001 12:36:21 +0100
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

    Hi!

    Could you provide an URL to that patch? I would like to test it.

    Regards.

    -Jorge

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
De: "Arjan van de Ven" <arjan@fenrus.demon.nl>
Para: "Petru Paler" <ppetru@ppetru.net>
CC: <linux-kernel@vger.kernel.org>
Enviado: lunes, 12 de febrero de 2001 10:34
Asunto: Re: RAID1 read balancing


> In article <20010211161242.A949@ppetru.net> you wrote:
>
> > For a RAID1 array built of two disks on two separate SCSI controllers,
> > are the reads balanced between the two controllers (for higher speed) ?
>
> With the current RAID1 setup, you will NOT get a speed increase for
> single-threaded, sequential reading programs (read: benchmarks like hdparm
> and tiobench)[1]. You will get improvents in all other cases.
>
> Greetings,
>    Arjan van de Ven
>
>
> [1] This can be fix by a 10 line patch, however this changes the on-disk
> layout.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
