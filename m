Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282073AbRKVIbk>; Thu, 22 Nov 2001 03:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282074AbRKVIbb>; Thu, 22 Nov 2001 03:31:31 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:38162 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S282073AbRKVIbO>; Thu, 22 Nov 2001 03:31:14 -0500
Date: Thu, 22 Nov 2001 16:30:58 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: "Marcel J.E. Mol" <marcel@mesa.nl>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dominik Kubla <kubla@sciobyte.de>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: New ac patch???
In-Reply-To: <20011122082930.A18888@joshua.mesa.nl>
Message-ID: <Pine.LNX.4.42.0111221628520.1799-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/22/2001
 04:31:08 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/22/2001
 04:31:11 PM,
	Serialize complete at 11/22/2001 04:31:11 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Nov 2001, Marcel J.E. Mol wrote:

> Does it have write caching enabled? check with hdparm ( I think you need one of
> the latest hdparm versions...)

# hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DJSA-220, FwRev=JS4OAC2A, SerialNo=44T44P30559
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1874kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=4216520955, LBA=yes, LBAsects=39070080
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4
ATA-5

Jeff

