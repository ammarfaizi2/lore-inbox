Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135190AbRARWaP>; Thu, 18 Jan 2001 17:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbRARWaF>; Thu, 18 Jan 2001 17:30:05 -0500
Received: from sanrafael.dti2.net ([195.57.112.5]:7947 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S135190AbRARW3u>;
	Thu, 18 Jan 2001 17:29:50 -0500
Message-ID: <005801c0819e$6c5c0640$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <001c01c08199$387205f0$067039c3@cintasverdes> <20010118161000.A3487@mediaone.net>
Subject: RE: ERR in /proc/interrupts
Date: Thu, 18 Jan 2001 23:31:38 +0100
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

    Are IPI related to SMP machines? This is not an SMP machine nor kernel.

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
De: "Tim Walberg" <tewalberg@mediaone.net>
Para: "Jorge Boncompte (DTI2)" <jorge@dti2.net>
CC: <linux-kernel@vger.kernel.org>
Enviado: jueves, 18 de enero de 2001 23:10
Asunto: Re: ERR in /proc/interrupts

A quick perusal of the 2.2.18 source code (I don't have
a copy of 2.4.x handy) shows that it's directly
related to the number of IPIs (inter-processor
interrupts) the system has taken. I'm not real
sure under what conditions this occurs, but it's
someplace to start...




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
