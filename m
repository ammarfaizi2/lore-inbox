Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbRHRWST>; Sat, 18 Aug 2001 18:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268917AbRHRWSJ>; Sat, 18 Aug 2001 18:18:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51209 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268957AbRHRWSE>; Sat, 18 Aug 2001 18:18:04 -0400
Subject: Re: 2.4.9: GCC 3.0 problem in "acct.c"
To: spam-goes-to-dev-null@gmx.net (peter k.)
Date: Sat, 18 Aug 2001 23:21:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "peter k." at Aug 18, 2001 08:09:37 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YESl-0001nN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i just updated my gcc from 2.96 to 3.0.1 and now i cant compile kernel 2.4.9
> anymore, make bzImage fails with the following error message:
> 
> acct.c: In function `check_free_space':
> acct.c:147: Unrecognizable insn:
> (insn 335 102 336 (parallel[
>             (set (reg/v:SI 2 ecx [44])
>                 (const_int 0 [0x0]))
>             (clobber (reg:CC 17 flags))
>         ] ) -1 (insn_list:REG_DEP_ANTI 100 (insn_list:REG_DEP_ANTI 102
> (nil)))
>     (expr_list:REG_UNUSED (reg:CC 17 flags)
>         (nil)))
> acct.c:147: Internal compiler error in insn_default_length, at
> insn-attrtab.c:223
> 
> can anyone tell me how to fix this?

Use gcc 2.96 or gcc 3.0.0. You broke the compiler. Please also see the gcc bug
reporting instructions. You will actually make a gcc hacker very happy 
reporting that problem.

