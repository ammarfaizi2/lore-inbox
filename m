Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTAYVL0>; Sat, 25 Jan 2003 16:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTAYVL0>; Sat, 25 Jan 2003 16:11:26 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:12548 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262224AbTAYVL0>; Sat, 25 Jan 2003 16:11:26 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200301252120.h0PLKMnA001974@green.mif.pg.gda.pl>
Subject: Re: BIOS setup needed for LBA48?
To: andre@linux-ide.org
Date: Sat, 25 Jan 2003 22:20:22 +0100 (CET)
Cc: stesmi@stesmi.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200301252107.h0PL7VA06508@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Jan 25, 2003 10:07:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, if the host controller can not handle the double pump for dma
> operations.  Disable DMA int it has to work.  If it does not, you have a
> nice pile of junk, and it should be come a door.

Shouldn't the driver disable DMA automatically (not allow to enable it) ?
Driver knows the controller type, knows the disk size ...

Or is it not so simple ?


> On Sat, 25 Jan 2003, Stefan Smietanowski wrote:
> 
> > >>Can the Linux Kernel use the full drive (160GB/250GB/whatever)
> > >>even though the BIOS doesn't? (LBA48)
> > > 
> > > Usually, yes.
> > 
> > Is there anything that could make "usually, yes" become a "no"?

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
