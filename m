Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271952AbRH2MHu>; Wed, 29 Aug 2001 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271953AbRH2MHk>; Wed, 29 Aug 2001 08:07:40 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:10116 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S271952AbRH2MH0>; Wed, 29 Aug 2001 08:07:26 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108291207.f7TC7SQ06387@sunrise.pg.gda.pl>
Subject: Re: linux 2.4.9 make menuconfig bug
To: david.balazic@uni-mb.si (David Balazic)
Date: Wed, 29 Aug 2001 14:07:28 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B8CB2D6.4628C91C@uni-mb.si> from "David Balazic" at Aug 29, 2001 11:16:06 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Balazic wrote:"
> kernel 2.4.9
> 
> make menuconfig
> on menu point "Fusion MPT device support" "Select" does nothing !
> it should go into a submenu

Normal behaviour for empty menu.

All "fusion" options depend on CONFIG_SCSI and CONFIG_BLK_DEV_SD.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
