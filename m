Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTE2Qn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTE2Qn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:43:57 -0400
Received: from miranda.zianet.com ([216.234.192.169]:36618 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S262383AbTE2Qny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:43:54 -0400
Message-ID: <3ED63BE7.8080604@zianet.com>
Date: Thu, 29 May 2003 10:57:11 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
References: <20030529114001.GD7217@louise.pinerecords.com> <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well if it helps at all I can vouch for the brokeness on the
Proliant ML530.  Granted this is not with a 2.4.21-rc kernel
but a RedHat kernel 2.4.20-13.9smp.  Luckily I don't use IDE
drives in this system but it did force me to do a network install
since the CDROM is now unusable.  Here is the error out of dmesg:

SvrWks CSB5: IDE controller at PCI slot 00:0f.1
SvrWks CSB5: chipset revision 147
SvrWks CSB5: not 100% native mode: will probe irqs later
SvrWks CSB5: simplex device: DMA forced
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:pio, hdb:pio
SvrWks CSB5: simplex device: DMA forced
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:DMA
hda: HL-DT-ST CD-ROM GCR-8480B, ATAPI CD/DVD-ROM drive
hda: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hda: set_drive_speed_status: error=0x04

If any futher info is needed give me a yell.

Steve

Alan Cox wrote:

>On Iau, 2003-05-29 at 12:40, Tomas Szepe wrote:
>  
>
>>o  2.4.21-rc6
>>	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
>>
>>o  2.4.21-rc2-ac3
>>	r/w in pio ok, dma hosed
>>
>>o  2.4.20
>>	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
>>    
>>
>
>The driver basically hasnt changed throughout these. Are you sure you
>don't just have a bust Proliant - anyone else runnign 2.4.21-rc on a
>proliant ?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


