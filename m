Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRDSSvE>; Thu, 19 Apr 2001 14:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDSSuy>; Thu, 19 Apr 2001 14:50:54 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:30995 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132629AbRDSSui>; Thu, 19 Apr 2001 14:50:38 -0400
Date: Thu, 19 Apr 2001 13:49:47 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: esr@thyrsus.com, Russell King <rmk@arm.linux.org.uk>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Cross-referencing frenzy
Message-ID: <20010419134947.F24230@cadcamlab.org>
In-Reply-To: <20010418233445.A28628@thyrsus.com> <20010419090220.A2291@flint.arm.linux.org.uk> <20010419091623.D31701@thyrsus.com> <3ADEF360.45B4F4E8@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3ADEF360.45B4F4E8@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 10:17:04AM -0400
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [esr]
> > CONFIG_SOUND_YMPCI: arch/ppc/configs/power3_defconfig arch/arm/def-configs/footbridge arch/arm/def-configs/rpc arch/arm/def-configs/lart arch/arm/def-configs/shark

[jgarzik]
> typo, that should be ...YMFPCI.

Actually it's not a typo (although the fix is the same).  The old
"SB-compatible mode" Yamaha driver was indeed CONFIG_SOUND_YMPCI.  That
allowed the two to coexist while the native-mode driver matured.

Peter
