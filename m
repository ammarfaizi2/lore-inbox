Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3Xk0>; Thu, 30 Nov 2000 18:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130990AbQK3XkQ>; Thu, 30 Nov 2000 18:40:16 -0500
Received: from 13dyn73.delft.casema.net ([212.64.76.73]:29445 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129257AbQK3XkH>; Thu, 30 Nov 2000 18:40:07 -0500
Message-Id: <200011302309.AAA04497@cave.bitwizard.nl>
Subject: Re: [PATCH] New user space serial port driver
In-Reply-To: <200011301654.QAA01657@raistlin.arm.linux.org.uk> from Russell King
 at "Nov 30, 2000 04:54:26 pm"
To: Russell King <rmk@arm.linux.org.uk>
Date: Fri, 1 Dec 2000 00:09:25 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@bitwizard.nl>,
        Tigran Aivazian <tigran@veritas.com>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@bitwizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Rogier Wolff writes:
> > Documentation bug. Not code bug. 
> 
> In which case, can we put it in as a documentation fix rather than changing
> the compiler output?  ie, /* = { NULL, } */ ?

Because I care more about the 4 bytes of extra source than the
4 bytes of extra object. 

I consider the 4 bytes of extra object code a compiler bug, and if we
start catering for that, the bug in the compiler will never be fixed.

This is similar to how Linus forced the recognition of the
"unroll-loops" bug by the gcc team. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
