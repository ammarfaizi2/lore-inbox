Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSL2TIR>; Sun, 29 Dec 2002 14:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSL2TIR>; Sun, 29 Dec 2002 14:08:17 -0500
Received: from tag.witbe.net ([81.88.96.48]:30227 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S261427AbSL2TIP> convert rfc822-to-8bit;
	Sun, 29 Dec 2002 14:08:15 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Alvaro Lopes'" <alvieboy@alvie.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53] So sloowwwww......
Date: Sun, 29 Dec 2002 20:16:35 +0100
Message-ID: <00c601c2af6e$ce3b4790$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <3E0F4526.9030702@alvie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

[root@donald rol]# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD800BB-00CAA1, FwRev=17.07W17, SerialNo=WD-WMA8E2546592
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5

Problem is much more likely to be related to ACPI.

Paul


Paul Rolland, rol@witbe.net
Witbe.net SA
Directeur Associe

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un
navigateur

"Some people dream of success... while others wake up and work hard at
it"

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alvaro Lopes
> Sent: Sunday, December 29, 2002 7:56 PM
> To: Paul Rolland
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [2.5.53] So sloowwwww......
> 
> 
> Paul Rolland wrote:
> 
> >Hello,
> >
> >I'm just playing a little bit with Kernel 2.5.53, and I've been
> >afraid of finding it quite slow...
> >
> >  
> >
> Just to be sure, have you got DMA enabled on your disks ?
> 
> What is the result of:
> 
> # hdparm -i /dev/hda
> # hdparm -i /dev/hdb
> 
> 
> -- 
> 
> Álvaro Lopes 
> ---------------------
> A .sig is just a .sig
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

