Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132793AbRAYSPl>; Thu, 25 Jan 2001 13:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135670AbRAYSPb>; Thu, 25 Jan 2001 13:15:31 -0500
Received: from 216-064-003-018.inaddr.vitts.com ([216.64.3.18]:39693 "EHLO
	mail.netx4.com") by vger.kernel.org with ESMTP id <S135632AbRAYSPQ>;
	Thu, 25 Jan 2001 13:15:16 -0500
Message-ID: <3A706C6F.4357762E@mvista.com>
Date: Thu, 25 Jan 2001 13:11:59 -0500
From: Dan Malek <dan@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.15-2.9.d ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: jekacur@ca.ibm.com
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: sigcontext on Linux-ppc in user space]
In-Reply-To: <OF38EA3C4D.2A886AF4-ON852569DF.00530F62@LocalDomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jekacur@ca.ibm.com wrote:

> ...... But I
> still can't get at the sigcontext.c on Linux Powerpc. For example, this
> simple program gives me a segmentation fault. (Linux ppc, suse 6.4, kernel
> 2.2.14

You are not the only one.  I recently discovered some inconsistent
data structures and function calls (sigaction, old_sigaction, different
context structures, etc.).  I spent some time trying to sort it out
but didn't have enough time.  I was fortunate and just bailed out using
old signal handler semantics.  I was using what I believed were the
latest glibc2.1, and also the latest 2.4 kernels (which is what I
was really developing and testing).  I mentioned this to some folks
closer to the glibc action, but haven't followed up.  Something is
amiss here with PowerPC.

Sorry I can't provide a solution.


	-- Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
