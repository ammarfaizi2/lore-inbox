Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbSLQPpB>; Tue, 17 Dec 2002 10:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSLQPpB>; Tue, 17 Dec 2002 10:45:01 -0500
Received: from web20507.mail.yahoo.com ([216.136.226.142]:65406 "HELO
	web20507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264624AbSLQPo5>; Tue, 17 Dec 2002 10:44:57 -0500
Message-ID: <20021217155255.31227.qmail@web20507.mail.yahoo.com>
Date: Tue, 17 Dec 2002 07:52:55 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: another seagate for the black-list?
To: Aryix <aryix@softhome.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <courier.3DFF30A8.000033A8@softhome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From dmesg that you sent me:

hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide1: reset: success
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
ide1: reset: success

which shows CRC errors. And in this case, there will
be a UDMA downgrade. Send me the SMART data using
smartctl and replace the cabling. The drive is
initialized UDMA 66

hda: 58633344 sectors (30020 MB) w/418KiB Cache,
CHS=3649/255/63, (U)DMA
blk: queue c030a928, I/O limit 4095Mb (mask
0xffffffff)
hdc: 12596850 sectors (6450 MB) w/256KiB Cache,
CHS=13330/15/63, UDMA(66)

but the UDMA is downgraded on CRC. Thats the expected
behavior



--- Aryix <aryix@softhome.net> wrote:
> On Tue, 17 Dec 2002 06:07:34 -0800
> Manish Lachwani <manish@Zambeel.com> wrote:
> 
> >  Did you send me dmesg o/p?
> > 
> > Send me e-mail at m_lachwani@yahoo.com since I
> will access that shortly 
> > 
> > 
> > 
> > -----Original Message-----
> > From: Aryix
> > To: Manish Lachwani
> > Sent: 12/17/02 5:48 AM
> > Subject: Re: another seagate for the black-list?
> > 
> > On Tue, 17 Dec 2002 05:45:57 -0800
> > Manish Lachwani <manish@Zambeel.com> wrote:
> > 
> > > When you use hdparm -X ..., can you also check
> dmesg for any IDE
> > warnings.
> > > Also, do a hdparm -I /dev/hdX 
> > > 
> Thank you!
>
--------------------------------------------------------------------------
> pub  1024D/BE8E00BE 2002-12-06 Aryix Berius
> (nothing) <aryix@softhome.net>
>      Key fingerprint = 249D C5BC 8B9A C46A C7F4 
> 397D 2A6D 9FF6 BE8E 00BE
> sub  2048g/C1C6CB29 2002-12-10 (linux.sophia.org.ar
> at 200.70.32.145)
> 
> 

> ATTACHMENT part 2 application/octet-stream
name=dmesg



__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
