Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVGVJQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVGVJQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVGVJQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:16:40 -0400
Received: from mrqout2.tiscali.it ([195.130.225.12]:1207 "EHLO
	mrqout2.tiscali.it") by vger.kernel.org with ESMTP id S261212AbVGVJQj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:16:39 -0400
Date: Fri, 22 Jul 2005 11:16:35 +0200
Message-ID: <42D7AA0C000145DB@mail-8.mail.tiscali.sys>
In-Reply-To: <20050722084805.GA10207@merlin.emma.line.org>
From: sampei02@tiscali.it
Subject: Re: DriveStatusError BadCRC
To: "Matthias Andree" <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I already used 80-wire cable and my Maxtor HD plugs are seated properly.
My Kernel is 2.6.12-1.1372 on Fedora Core 3
HD is 80 GB Maxtor ATA/133
With hdparm command I can see hda is set in "udma5" mode, but why is'it not
udma6 (133 Mhz) ? Can it be problem ?!

Sampei


>-- Messaggio Originale --
>Date:	Fri, 22 Jul 2005 10:48:05 +0200
>From:	Matthias Andree <matthias.andree@gmx.de>
>To:	linux-kernel@vger.kernel.org
>Subject: Re: DriveStatusError BadCRC
>
>
>On Fri, 22 Jul 2005, sampei02@tiscali.it wrote:
>
>> I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving
>this
>> message:
>> 
>> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>> hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>
>> How can I solve it ?
>
>Check your hardware. ATA cables must not exceed 45 cm in length; for
>Ultra DMA 4, 5 or 6 (66 MByte/s and faster), you need to use 80-wire
>cables (they need extra ground lines for shielding), and check if all
>plugs are seated properly.
>
>WRT the backtrace you showed, someone else will have to answer - which
>kernel version are you using? If it's a Fedora-patched kernel, report
>the problem to the Fedora project. If it's an older unmodified kernel,
>retry with a newer kernel (2.6.12.3) first and see if the problem is
>still present.
>
>-- 
>Matthias Andree
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________________________
TISCALI ADSL 1.25 MEGA
Solo con Tiscali Adsl navighi senza limiti e telefoni senza canone Telecom
a partire da  19,95 Euro/mese.
Attivala entro il 28 luglio, il primo MESE è GRATIS! CLICCA QUI.
http://abbonati.tiscali.it/adsl/sa/1e25flat_tc/



