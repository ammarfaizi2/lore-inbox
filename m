Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTKEXrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 18:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTKEXrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 18:47:05 -0500
Received: from drifthost.com ([66.28.242.251]:3275 "EHLO drifthost.com")
	by vger.kernel.org with ESMTP id S263302AbTKEXrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 18:47:01 -0500
Message-ID: <01ba01c3a3f7$1da22100$dfb21ad3@drifthost>
From: "Steven Adams" <steve@drifthost.com>
To: <linux-kernel@vger.kernel.org>
References: <200311042029.38749.andy@asjohnson.com> <1805.61.88.244.7.1068001546.squirrel@mail.drifthost.com>
Subject: Re: no DRQ after issuing WRITE
Date: Thu, 6 Nov 2003 10:42:49 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anyone?
----- Original Message ----- 
From: <steve@drifthost.com>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 05, 2003 2:05 PM
Subject: hda: no DRQ after issuing WRITE


> Hey guys,
>
> i keep getting things like this in my dmesg
>
> ============================================
> hda: status timeout: status=0xd0 { Busy }
>
> hda: no DRQ after issuing WRITE
> ide0: reset: success
> hda: status timeout: status=0xd0 { Busy }
>
> hda: no DRQ after issuing WRITE
> ide0: reset: success
> =============================================
>
> From hdparm
> ============================================
> /dev/hda:
>
>  Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>  BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=160836480
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>  AdvancedPM=yes: disabled (255) WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
> =================================================
>
> Ive searched high and low to try find out what this means, all ive found
> it people keep saying its all different kinds of things..
>
> I was wondering if this means my hdd is drying or is ti a setting?
>
> Thanks guys,
> Steve
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

