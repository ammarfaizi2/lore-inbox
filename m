Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbQKBMlZ>; Thu, 2 Nov 2000 07:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbQKBMlO>; Thu, 2 Nov 2000 07:41:14 -0500
Received: from jalon.able.es ([212.97.163.2]:17594 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130550AbQKBMlJ>;
	Thu, 2 Nov 2000 07:41:09 -0500
Date: Thu, 2 Nov 2000 13:40:58 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102134058.A904@werewolf.able.es>
In-Reply-To: <8625698B.00200009.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <8625698B.00200009.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Thu, Nov 02, 2000 at 06:46:04 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Nov 2000 06:46:04 Wayne.Brown@altec.com wrote:
> 
> 
> I've been following this kgcc discussion with interest for weeks now and
> there's
> one thing that still puzzles me.  Everyone on both sides of the issue seems to
> be saying that kgcc (AKA egcs 1.1.2) is used because the gcc versions shipped
                       ^^^^^^^^^^^^^^^
Wrong assumption. The idea is if I need a way to set a compiler for kernel
that is not the same compiler as the system wide one. Should kernel Makefiles
use gcc (hardcoded) (and people must have a 'gcc' that works for kernel), or
let kernel use something called 'kgcc', and let user decide if in his machine
kgcc is 2.7, egcs or 2.95.2.

> by
> several vendors don't compile the kernel correctly.  What I haven't seen yet
> is
> an explanation of why kgcc can't be used for compiling *everything* and why
> another compiler even needs to be installed.

Because gcc is not only the C compiler, is the full compiler system.
The support for C++ in 2.95 has nothing to do with egcs. And 2.95 supports
java, for example.
And the libraries. The C++ standard library is much better in 2.95 that in
egcs.


-- 
Juan Antonio Magallon Lacarta                          mailto:jamagallon@able.es

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
