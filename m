Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273819AbRIXIOo>; Mon, 24 Sep 2001 04:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273820AbRIXIOe>; Mon, 24 Sep 2001 04:14:34 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:34541 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S273819AbRIXIOR>; Mon, 24 Sep 2001 04:14:17 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200109240814.f8O8E4E00975@sunrise.pg.gda.pl>
Subject: Re: [PATCH] PART1: Proposed init & module changes for 2.5
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 24 Sep 2001 10:14:03 +0200 (MET DST)
Cc: dcinege@psychosis.com, linux-kernel@vger.kernel.org
In-Reply-To: <E15lOLW-0000SC-00@wagner> from "Rusty Russell" at Sep 24, 2001 03:31:58 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rusty Russell wrote:"
> > I don't suggest implementing the complete module loading in the boot loader,
> > (I'm still not even sure I really like it in the kernel.  ; > )
[...]
> > only loading the modules themselves into memory for the kernel access during 
> > it's exec. (Like an initrd image is loaded) If a boot loader wants to 
> > understand and use modules.dep or do on the fly dependency checking, or have 
> > kernel userland utils to update it's conifg intelligently, that's it's 
> > business. I only want to see a way modules can be preloaded before kernel 
> > exec.
> 
> Why not just put them in the initrd image?  The kernel is not going to
> use the entire module as it is, so it will have to copy it anyway...

Somebody wants to modularize all binary formats, including binfmt_elf ... ?

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
