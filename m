Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311643AbSCNQLr>; Thu, 14 Mar 2002 11:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311645AbSCNQLh>; Thu, 14 Mar 2002 11:11:37 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:42757 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311643AbSCNQLZ>; Thu, 14 Mar 2002 11:11:25 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200203141611.RAA15178@green.mif.pg.gda.pl>
Subject: Re: 2.5.6: make xconfig croaks in with sound/core/Config.in
To: tyketto@wizard.com
Date: Thu, 14 Mar 2002 17:11:13 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200203141212.g2ECC3N10085@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Mar 14, 2002 01:12:03 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>         Short, but sweet:
> 
> root@bellicha:/usr/src/linux# head -10 Makefile
> VERSION = 2
> PATCHLEVEL = 5
> SUBLEVEL = 6
> EXTRAVERSION =
[...]
> gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
  ^^^^^^^^^^^^^^^^^^^^^^^
Error location seems to be clear.
Forgotten dependency ?

> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.5/scripts'
> make: *** [xconfig] Error 2
> 
> [2]+  Exit 2                  make xconfig

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
