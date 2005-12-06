Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVLFGXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVLFGXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 01:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLFGXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 01:23:23 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:23870 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S964924AbVLFGXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 01:23:23 -0500
Date: Mon, 5 Dec 2005 22:23:22 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE performance on notebooks [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Message-ID: <20051206062322.GP22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz> <20051206014720.GN22168@hexapodia.org> <20051206015616.GK1770@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206015616.GK1770@elf.ucw.cz>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 02:56:16AM +0100, Pavel Machek wrote:
> Below are data from my machine... but that should be moved to
> linux-ide or something. This thinkpad is from this summer, too, BTW.
> 
> /dev/hda:
>  Model=HTS541040G9AT00, FwRev=MB2IA5BJ, SerialNo=MPB2L0X2GLMG5M

Alas, the reason for my poor disk performance becomes clear - it's a
1.8" drive!  Gah, if I'd known that I wouldn't have bought this laptop
(though I *do* like it in other regards).

/dev/hda:

 Model=HTC426040G9AT00, FwRev=00P4A0B4, SerialNo=121611
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a: 

 * signifies the current active mode

-andy
