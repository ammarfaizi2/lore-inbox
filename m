Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSE2UDO>; Wed, 29 May 2002 16:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSE2UDN>; Wed, 29 May 2002 16:03:13 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:6651 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S315454AbSE2UDM>; Wed, 29 May 2002 16:03:12 -0400
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE breakage with cdrom in 2.5.18+
In-Reply-To: <3CF53160.B97CE3E2@delusion.de>
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: Wed, 29 May 2002 22:02:23 -0400
Message-ID: <m2it56jsuo.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.2
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" <reality@delusion.de> writes:

> /dev/hde shows packet command errors upon bootup. Any ideas?

> hda: IBM-DTLA-307030, ATA DISK drive
> hdb: IBM-DTLA-307030, ATA DISK drive
> hde: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM drive
> ide0 at 0x9400-0x9407,0x9002 on irq 10
> ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
>  hda: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
>  hda: hda1
>  hdb: 60036480 sectors w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
>  hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 >
> hde: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> hde: packet command error: status=0x51 { DriveReady SeekComplete Error } 
> hde: packet command error: error=0x54
> ATAPI device hde:
>   Error: Illegal request -- (Sense key=0x05)
>   Invalid field in command packet -- (asc=0x24, ascq=0x00)
>   The failed "Request Sense" packet command was: 
>   "03 00 00 00 12 00 00 00 00 00 00 00 "

afaic looks "try to detect partitions" lookup that should not had been
done on cdrom :-(

-- 
"j'aime warly qui est beau parce que je l'aime et qu'il est beau" (gc)
"apres le gps, le ps" (pixel)

