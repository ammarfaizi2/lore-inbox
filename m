Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbRAaI1g>; Wed, 31 Jan 2001 03:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130572AbRAaI10>; Wed, 31 Jan 2001 03:27:26 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:43667 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130476AbRAaI1N>; Wed, 31 Jan 2001 03:27:13 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200101310826.JAA00284@sunrise.pg.gda.pl>
Subject: Re: Multiple SCSI host adapters, naming of attached devices
To: michael@wd21.co.uk (Michael Pacey)
Date: Wed, 31 Jan 2001 09:26:55 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010130230633.B388@kermit.wd21.co.uk> from "Michael Pacey" at Jan 30, 2001 11:06:33 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Pacey wrote:"
> Of course I should have said this is linux kernel 2.2.17, an IBM PS/2 9585,
> in-built 'IBM MCA' SCSI adapter and an AHA-1640 MCA card.
> 
> I now realise that in 2.4 I can use scsihosts=ibmmca:aha1542, but have no
> info for 2.2.17.
> 
> Sorry for the lack of info previously :)

If the scsihosts= parameter helps you, you can look for a devfs patch for
2.2 kernels at
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/

--
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
