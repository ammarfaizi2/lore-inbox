Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313182AbSDDOs0>; Thu, 4 Apr 2002 09:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313183AbSDDOsQ>; Thu, 4 Apr 2002 09:48:16 -0500
Received: from lucy.ulatina.ac.cr ([163.178.60.3]:15368 "EHLO
	lucy.ulatina.ac.cr") by vger.kernel.org with ESMTP
	id <S313182AbSDDOsL>; Thu, 4 Apr 2002 09:48:11 -0500
Subject: Re: linux-2.5.7
From: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>, Richard Henderson <rth@twiddle.net>
In-Reply-To: <20020404014223.A22363@twiddle.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 04 Apr 2002 08:45:10 -0600
Message-Id: <1017931510.1567.4.camel@lucy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rather, "the ancient version of gcc commonly used on sparc64".

I'm sort of forwading a message I wrote at March 13th that was never
answered and that I think has a huge priority for the sparc64 port.

--
>    GCC 3.0.3 works.
>    
> (Dave S. Miller wrote)
> I won't accept kernel bug reports for people using it though.
> The old egcs64 compiler is the only thing I trust right now, still.

In that case, I would repectfully comment that a special case comment
should be added to the lkml FAQ (chapter 8, section 2), because there,
it is stated:

"
    2. What are the recommended compiler/binutils for building kernels?

* (REG) This depends on the kernel version. Until 26-OCT-2000, gcc
2.7.2.3 was the recommended compiler for all kernels. On this date,
Linus announced that gcc 2.91.66 (aka egcs 1.1.2) is the recommended
compiler for 2.4.x kernels up to version 2.4.9. Gcc 2.95.3 is the
recommended compiler for kernel 2.4.10 and later.

(...)
            Always see the Documentation/Changes file for details.
"

At Documentation/Changes you can read some negative comments about this
version of the compiler, and it even says that is likely that 2.5 will
drop egcs workarrounds.

How will this be managed? What is the recommended compiler for 2.5?

-- 
Alvaro Figueroa

