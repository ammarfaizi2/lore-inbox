Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271971AbRH2Nzq>; Wed, 29 Aug 2001 09:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271974AbRH2Nzg>; Wed, 29 Aug 2001 09:55:36 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:23045 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S271971AbRH2Nz1>; Wed, 29 Aug 2001 09:55:27 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108291355.PAA04915@green.mif.pg.gda.pl>
Subject: Re: linux 2.4.9 make menuconfig bug
To: david.balazic@uni-mb.si (David Balazic)
Date: Wed, 29 Aug 2001 15:55:45 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3B8CE6C8.ED4F163B@uni-mb.si> from "David Balazic" at Aug 29, 2001 02:57:44 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > make menuconfig
> > > on menu point "Fusion MPT device support" "Select" does nothing !
> > > it should go into a submenu
> > 
> > Normal behaviour for empty menu.
> > 
> > All "fusion" options depend on CONFIG_SCSI and CONFIG_BLK_DEV_SD.
> 
> But if empty then it should no be listed at all, no ?
> That would make more sense IMHO.

Probably this need fixing in config files.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
