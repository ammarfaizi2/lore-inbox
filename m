Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUAMR2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbUAMR2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:28:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58344 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264586AbUAMR17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:27:59 -0500
Date: Tue, 13 Jan 2004 18:27:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113172751.GN9677@fs.tum.de>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org> <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 02:07:54PM +0100, Maciej W. Rozycki wrote:
> On Tue, 13 Jan 2004, Ralf Baechle wrote:
> 
> > > it seems the following is required in Linus' tree to get correct depends 
> > > for DECSTATION:
> > 
> > Thanks,  applied.
> 
>  The dependency was intentional: stable for 32-bit, experimental for
> 64-bit.  I'm reverting the change immediately.  Please always contact me
> before applying non-obvious changes for the DECstation.
> 
>  If there's anything wrong with the depends, it should be fixed elsewhere.  
> Details, please.

Does -mabi=64 really work on any DECstation?

AFAIK none of the R2000, R3x00 and the R4x00 do support the 64bit ABI.

>   Maciej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

