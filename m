Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTKFFX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 00:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbTKFFX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 00:23:29 -0500
Received: from drifthost.com ([66.28.242.251]:35297 "EHLO drifthost.com")
	by vger.kernel.org with ESMTP id S263366AbTKFFX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 00:23:26 -0500
Message-ID: <1796.61.88.244.7.1068096102.squirrel@mail.drifthost.com>
Date: Thu, 6 Nov 2003 16:21:42 +1100 (EST)
Subject: Re: no DRQ after issuing WRITE
From: <steve@drifthost.com>
To: <andre@linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10311052012260.28485-100000@master.linux-ide.org>
References: <20031106032133.GD19875@rdlg.net>
        <Pine.LNX.4.10.10311052012260.28485-100000@master.linux-ide.org>
X-Priority: 3
Importance: Normal
Cc: <Robert.L.Harris@rdlg.net>, <steve@drifthost.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.9)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well i only just started getting them and i started with 2.4.20 and
upgraded to 2.4.21 about 6weeks or so ago (or when it came out)

Started gettig errors about 4-5days ago..

Ive seen alot of other ppl with the same error on early kernels..

Any idea what it is

>
> I do not have time to pause and trace/fix the mess.
> However if you both can kindly finger the last kernel when you did not
> have this error, it will help constrain the pain.
>
> Cheers,
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> On Wed, 5 Nov 2003, Robert L. Harris wrote:
>
>>
>>
>> No answer for you but I've gotten this message also and was hoping
>> someone would know what/why...
>>
>>
>> Thus spake Steven Adams (steve@drifthost.com):
>>
>> > anyone?
>> > ----- Original Message -----
>> > From: <steve@drifthost.com>
>> > To: <linux-kernel@vger.kernel.org>
>> > Sent: Wednesday, November 05, 2003 2:05 PM
>> > Subject: hda: no DRQ after issuing WRITE
>> >
>> >
>> > > Hey guys,
>> > >
>> > > i keep getting things like this in my dmesg
>> > >
>> > > ============================================
>> > > hda: status timeout: status=0xd0 { Busy }
>> > >
>> > > hda: no DRQ after issuing WRITE
>> > > ide0: reset: success
>> > > hda: status timeout: status=0xd0 { Busy }
>> > >
>> > > hda: no DRQ after issuing WRITE
>> > > ide0: reset: success
>> > > =============================================
>> > >
>> > > From hdparm
>> > > ============================================
>> > > /dev/hda:
>> > >
>> > >  Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CBRJLA
>> Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>> > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>> > >  BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16,
>> MultSect=off CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
>> LBAsects=160836480 IORDY=on/off, tPIO={min:240,w/IORDY:120},
>> tDMA={min:120,rec:120} PIO modes:  pio0 pio1 pio2 pio3 pio4
>> > >  DMA modes:  mdma0 mdma1 mdma2
>> > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>> > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
>> > >  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5
>> > > =================================================
>> > >
>> > > Ive searched high and low to try find out what this means, all ive
>> found it people keep saying its all different kinds of things..
>> > >
>> > > I was wondering if this means my hdd is drying or is ti a setting?
>> > >
>> > > Thanks guys,
>> > > Steve
>> > >
>> > >
>> > > -
>> > > To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to
>> majordomo@vger.kernel.org
>> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> >
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> :wq!
>> ---------------------------------------------------------------------------
>> Robert L. Harris                     | GPG Key ID: E344DA3B
>>                                          @ x-hkp://pgp.mit.edu
>> DISCLAIMER:
>>       These are MY OPINIONS ALONE.  I speak for no-one else.
>>
>> Life is not a destination, it's a journey.
>>   Microsoft produces 15 car pileups on the highway.
>>     Don't stop traffic to stand and gawk at the tragedy.
>>



