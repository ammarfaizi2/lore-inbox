Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317782AbSHHSTb>; Thu, 8 Aug 2002 14:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317811AbSHHSTb>; Thu, 8 Aug 2002 14:19:31 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:50952 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317799AbSHHST2>;
	Thu, 8 Aug 2002 14:19:28 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Thu, 8 Aug 2002 20:22:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] pdc20265 problem.
CC: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
X-mailer: Pegasus Mail v3.50
Message-ID: <17291A73E81@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 02 at 10:30, Andre Hedrick wrote:
> 
> http://www.tyan.com/products/html/thunderlet.html

Page 40 of manual: choose Onboard IDE or FastTrak ATA-100/RAID.
OnboardIDE means Serverworks, FastTrak means PDC20265.
BIOS settings for primary/secondary disk relate to the Serverworks
channels.

> http://www.tyan.com/products/html/tiger200t.html

Page 11: Primary/secondary IDE: VIA, RAID primary/secondary: PDC.
Page 33: Primary/secondary IDE settings relate to the VIA.

> http://www.tyan.com/products/html/trinityi845e.html

Page 5: Integrated PCI IDE (it talks about i845 internal) +
integrated IDE RAID (20267, so no relevance here). Page 28:
primary/secondary disables i845, not PDC.

> http://www.tyan.com/products/html/trinitygcsl.html

Serverworks, with IDE. Serverworks IDE is primary.
RAID is 20267, so no relevance. Manual not available yet.

> http://www.epox.com/html/english/products/motherboard/ep-d3va.htm

VIA onboard, HPT370 RAID. Connectors of RAID marked IDE3/IDE4.

> http://www.epox.com/html/english/products/motherboard/ep-8k3a.htm

8k3a has no RAID. 8k3a+ has PDC20267. Primary IDE is from VIA,
RAID is additional...

> http://www.supermicro.com/PRODUCT/MotherBoards/VIA/370DDE.htm

Manual unavailable from the web (404 Page not found after clicking
on manual). Picture shows IDE #1/IDE #2 (VIA) and IDE RAID #1/#2.
Besides that it has PDC20267, so it has no relevance to this discussion.

> http://www.supermicro.com/PRODUCT/MotherBoards/VIA/P3TDDE.htm

Manual page #10: IDE1/IDE2 for VIA, IDE RAID #1/#2 for PDC.
Page 14: 2 IDE bus master interfaces support UDMA/100 (listed first),
2 IDE RAID connectors (listed later). Page 49: IDE primary/secondary
settings relate to the VIA.
 
> all know better, are wiser, empower w/ megalmania (sp) and gawd knows what
> else.  Please next time, do your homework before you attempt to call me
> on these issues.  Do the two word "Native" and "Compatablity" in ATA-ATAPI
> have meaning?  This will help you go a long way.

I did my homework. I still believe that there is NO MAINBOARD with
PDC20265, and without southbridge IDE - be it VIA, SiS, Intel or Nvidia.
All motherboards you listed have PDC (or HPT) as an additional controller,
and manual always refers to southbridge as IDE#1/IDE#2, while PDC
is referred as IDE RAID#1/#2, or even as IDE#3/IDE#4.

If you tried to prove that PDC20265 should never be ide0/ide1, then
we are on the same boat.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
P.S.: Both Tyan and Epox should make their ftp servers much, much faster...
                                                
