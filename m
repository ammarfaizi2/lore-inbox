Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130891AbQKGXuC>; Tue, 7 Nov 2000 18:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130586AbQKGXtx>; Tue, 7 Nov 2000 18:49:53 -0500
Received: from k2.llnl.gov ([134.9.1.1]:8837 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130751AbQKGXtk>;
	Tue, 7 Nov 2000 18:49:40 -0500
Message-ID: <3A084DEF.6A943BC9@scs.ch>
Date: Tue, 07 Nov 2000 10:46:07 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Alpha SMP problem
In-Reply-To: <3A08455E.F3583D1B@scs.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update: I just tested it on Alpha UP and everything's fine. It really
seems to be a SMP problem...

Reto Baettig wrote:
> 
> Hi
> 
> I have a problem whith Alpha SMP's which seems to be kernel-related. I
> discussed this on the bug-glibc list but everybody seems to agree that
> it cannot be a libc problem.
> 
> I attached a little testprogram which reproduces the bug in < 1Minute.
> BUT: IT MUST BE STARTED AT LEAST TWICE!
> 
> The strange thing is that a single instance of the program runs just
> fine. When I start the program a second time, I get segfaults and/or
> stuck threads.
> 
> We could reproduce this behaviour on different Machines, both with linux
> 2.2.14 and 2.4.0-test10, but
> ONLY ON ALPHA SMP MACHINES.
> 
> Here's my configuration:
> 
> Linux reto1 2.4.0-test10 #2 SMP Tue Oct 31 19:39:51 PST 2000 alpha
> unknown
>                             ^^^                              ^^^^^
> Kernel modules         2.3.19
> Gnu C                  egcs-2.91.66
> Gnu Make               3.78.1
> Binutils               2.9.5.0.22
> Linux C Library        2.1.3
> Dynamic linker         ldd (GNU libc) 2.1.3
> Procps                 2.0.6
> Mount                  2.10f
> Net-tools              1.54
> Console-tools          0.3.3
> Sh-utils               2.0
> Modules Loaded         nfs lockd sunrpc
> 
> Any ideas?
> 
> Please tell me when you need more information, or give me some pointers
> where I could start to dig...
> 
> TIA
> 
> Reto
> 
>   ------------------------------------------------------------------------
>                      Name: malloctest.tgz
>    malloctest.tgz    Type: unspecified type (application/octet-stream)
>                  Encoding: base64
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
