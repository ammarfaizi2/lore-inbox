Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSEDRjk>; Sat, 4 May 2002 13:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315096AbSEDRjj>; Sat, 4 May 2002 13:39:39 -0400
Received: from ALyon-104-1-2-38.abo.wanadoo.fr ([80.13.167.38]:4335 "EHLO
	coruscant") by vger.kernel.org with ESMTP id <S314885AbSEDRji>;
	Sat, 4 May 2002 13:39:38 -0400
Date: Sat, 4 May 2002 19:39:36 +0200
From: David Odin <David@dindinx.org>
To: linux-kernel@vger.kernel.org
Subject: agpgart problem with an msi Mobo.
Message-ID: <20020504173936.GA3876@coruscant>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi,

I've recently bought an agp graphic card, so I would like to use the
agpgart.o module, but it doesn't seems to work with my mother board:
coruscant:~# modprobe agpgart
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
/lib/modules/2.5.13/kernel/drivers/char/agp/agpgart.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.5.13/kernel/drivers/char/agp/agpgart.o: insmod
/lib/modules/2.5.13/kernel/drivers/char/agp/agpgart.o failed
/lib/modules/2.5.13/kernel/drivers/char/agp/agpgart.o: insmod agpgart failed

As you can see, I'm using the 2.5.13 kernel, but I had the same error
with 2.4.17.

My mother board is an MSI K7T266 Pro2.

  Any ideas? Is this a known problem? Is this due to some wrong setting
in my bios?

  I can test any patch, if needed.

          Thanks,

                  DindinX


-- 
David@dindinx.org
