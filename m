Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSHHMmk>; Thu, 8 Aug 2002 08:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSHHMmk>; Thu, 8 Aug 2002 08:42:40 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:13572 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316880AbSHHMmi>;
	Thu, 8 Aug 2002 08:42:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Hedrick <andre@linux-ide.org>
Date: Thu, 8 Aug 2002 14:45:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] pdc20265 problem.
CC: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
X-mailer: Pegasus Mail v3.50
Message-ID: <16CF2372467@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 02 at 3:50, Andre Hedrick wrote:
> On Wed, 7 Aug 2002, Bill Davidsen wrote:
> 
> > I would just as soon use a boot option as to try and make it a compile
> > option, and I think that many people just use a compiled kernel and never
> > change, which argues for a reasonable default (most pdc20265) ARE
> > currently offboard, and an easy way to change it.
> 
> There are ZERO pdc20265's offboard, only pdc20267's were in both options.
> This is the direct asic packaging.  Thus all pdc20265 have the right to be
> listed as onboard.  If you have a pdc20265 on an add-on card please send
> me a digital photo so I can question promise as to why.

They are on the mainboard, but mainboard has also (in my case VIA) IDE
chipset on the shelf, and BIOS shows everywhere (autodetection, IDE config)
that VIA is the primary chipset, and PDC ('UDMA100' interface in the BIOS)
is an additional, optional, interface. So forcing PDC20265 as primary is 
a bug - it is not consistent with BIOS, it is not consistent with Windows, 
and it is not consistent with other Linux versions.

Up to now nobody showed me mainboard which has PDC20265, but which does
not have other IDE chipset integrated in the southbridge, or at least
mainbord with BIOS which names disks connected to the PDC primary/secondary
master/slave. It is 3rd/4th channel on all mainboards I ever saw.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
