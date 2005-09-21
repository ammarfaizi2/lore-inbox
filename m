Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVIUOvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVIUOvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVIUOvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:51:14 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:5095
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S1751024AbVIUOvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:51:13 -0400
Subject: RE: How to Force PIO mode on sata promise (Linux 2.6.10)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-class: urn:content-classes:message
Date: Wed, 21 Sep 2005 16:48:31 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FB9@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to Force PIO mode on sata promise (Linux 2.6.10)
thread-index: AcW+tuMt2O8NUSKAQ1eEAqXiDEGgvgABJQjw
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clemens,

How did you disabled the DMA ?

David 

-----Message d'origine-----
De : Clemens Koller [mailto:clemens.koller@anagramm.de] 
Envoyé : mercredi 21 septembre 2005 16:15
À : David Sanchez
Cc : Jeff Garzik; linux-kernel@vger.kernel.org
Objet : Re: How to Force PIO mode on sata promise (Linux 2.6.10)

Hello, David, Jeff!

> I'm using the linux kernel 2.6.10 and busybox on an AMD db AU1550 with a
> hdd connected to the pata port of a PCI card (Promise PDC20579).

I'm using a PDC20269 (on Promise Ultra133TX2 card) w/ DMA disabled on
an embedded ppc (MPC8540). I cannot use DMA, too.
I guess it's a PCI IRQ/REQ/GNT problem on my board.
With DMA disabled I haven't had any problems on my system.
I am going to use a PDC20275 in the future.

My .config of a linux-2.6.13-rc7 is attached.

And... I know other guys with similar problems on embedded environments.
Unfortunately I wasn't able to have a closer look at this problem yet.

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


