Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310325AbSCGNh1>; Thu, 7 Mar 2002 08:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310324AbSCGNhS>; Thu, 7 Mar 2002 08:37:18 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:63236 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S310325AbSCGNhG>; Thu, 7 Mar 2002 08:37:06 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200203071336.OAA06410@green.mif.pg.gda.pl>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: hanky@promise.com.tw
Date: Thu, 7 Mar 2002 14:36:38 +0100 (CET)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        crimsonh@promise.com.tw, jennyl@promise.com.tw, linusc@promise.com.tw,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <200203071331.g27DVi211087@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at Mar 07, 2002 02:31:45 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   /* Give size in megabytes (MB), not mebibytes (MiB). */
> >   /* We compute the exact rounded value, avoiding overflow. */
> > - printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
> > + printk (" (%ld GB)", ((capacity - capacity/625 + 974)/1950)/1024);
> 
> We use Mb for a reason (old disks look odd) - maybe using Gb once its >=
> 2Gb would work to make it look neater ?

And please, use well defined units. Here
1GB = 1024 * 10^6 bytes

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
