Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270142AbRHGNwW>; Tue, 7 Aug 2001 09:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270212AbRHGNwM>; Tue, 7 Aug 2001 09:52:12 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:36298 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270142AbRHGNv7>; Tue, 7 Aug 2001 09:51:59 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108071351.PAA03284@sunrise.pg.gda.pl>
Subject: Re: is this a bug?
To: thodoris@cs.teiher.gr (Thodoris Pitikaris)
Date: Tue, 7 Aug 2001 15:51:48 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B6FD644.7020409@cs.teiher.gr> from "Thodoris Pitikaris" at Aug 07, 2001 02:51:32 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Thodoris Pitikaris wrote:"
> As you will see in the attached file (it's a dmesg from the boot)
> I have an 1Ghz athlon cpu with a VIA KT133 on a gigabyte GA-7ZX 
> motherboard with 100mhz SDRAM.When I compiled the kernel with 
> cputype=Athlon I continiusly experienced this crash.When I compiled with 
> cputype=i686 everything went smooth (OS is Redhat 7.1)        

Try the newest -ac patches. They contain discussed on the list workaround
for a VIA chipset bug.
VIA chipsets seem to be unstable when processing fast memory-to-memory
copy.

It is definitely not an Athlon processor problem.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
