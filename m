Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271623AbRIGIj4>; Fri, 7 Sep 2001 04:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271620AbRIGIjq>; Fri, 7 Sep 2001 04:39:46 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:27332 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S271619AbRIGIjf>; Fri, 7 Sep 2001 04:39:35 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200109070839.f878dIw00545@sunrise.pg.gda.pl>
Subject: Re: Athlon doesn't like Athlon optimisation?
To: blackfoot@yifan.net
Date: Fri, 7 Sep 2001 10:39:18 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <PAEKIKPEKOCEFPAENNPCOELICBAA.blackfoot@yifan.net> from "Jim Blomo" at Sep 07, 2001 12:33:55 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jim Blomo wrote:"
> Hi, I am having a similar problem with my new board/chip. I am using
> 2.4.10-pre4, and when I compile with the Athlon/Thunderbird setting, the
> kernel does absolutely nothing after being uncompressed by LILO. The
> computer locks up and I must do a hard reboot to get going again. I have had
> no errors (for about 1.5 days) when using the same kernel compiled as 386
> and Pentium pro without any other changes. When I used make bzdisk and tried
> to boot from that, it repeated the following message over and over until I
> did a soft reset:
> 
> 1007
> AX:020C
> BX:0000
> CX:0007
> DX:0000

This has nothing to do with Athlon optimization. This is probably a broken
floppy disk.

This seem to be from the bootsector code from arch/i386/bootsect.S, it is
exactly the same for all x86 processors and called before any other code.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

