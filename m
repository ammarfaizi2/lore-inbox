Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFAkB>; Fri, 5 Jan 2001 19:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAFAjv>; Fri, 5 Jan 2001 19:39:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:38345 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129267AbRAFAjp>;
	Fri, 5 Jan 2001 19:39:45 -0500
To: linux-kernel@vger.kernel.org
Cc: Lukas Dobrek <dobrek@itp.uni-hannover.de>
Subject: Re: Problem with compiling 2.2.18 on AXP
In-Reply-To: <20010106011533.A1344@alya.uni-hannover.de>
From: David Huggins-Daines <dhd@eradicator.org>
Organization: None worth mentioning
Date: 05 Jan 2001 19:38:59 -0500
Message-ID: <87pui1y0nw.fsf@monolith.cepstral.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Dobrek <dobrek@itp.uni-hannover.de> writes:

> Hello,
> I've following problem with compiling kernel-2.2.18 on AXP machine:
> 
> make -C  arch/alpha/lib
> make[1]: Entering directory `/home/users/builder/rpm/BUILD/linux/arch/alpha/lib'
> /usr/bin/kgcc -D__KERNEL__ -I/home/users/builder/rpm/BUILD/linux/include -D__ASSEMBLY__  -c -o stxcpy.o stxcpy.S
> stxcpy.S:22: alpha/regdef.h: No such file or directory
> make[1]: *** [stxcpy.o] Error 1
> 
> Surprisingly this is true, this file exist only in asm-mips. 

This file should have been installed with your glibc headers (though
its absence in the kernel is probably a bug, either that or its use
is).

Complain to your distribution vendor.

-- 
David Huggins-Daines		-		dhd@eradicator.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
