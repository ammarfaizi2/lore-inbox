Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293397AbSCEPsU>; Tue, 5 Mar 2002 10:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293396AbSCEPsK>; Tue, 5 Mar 2002 10:48:10 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:1920 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S293395AbSCEPsH>; Tue, 5 Mar 2002 10:48:07 -0500
Message-Id: <200203060425.g264PaO00901@dirty-bastard.pthbb.org>
To: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: Tulip bug? 
Date: Tue, 05 Mar 2002 23:25:36 -0500
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I managed to switch the console to the 8x9 font which gave 42 lines of
spew... No mention of tulip this time, at least not in what was visible.
Also none of these ever get logged to messages so ksymoops wouldn't help?
Most of it is Call Trace and Stack, which I am guessing is useless without
knowing the exact state of the machine before hand (I do have Call Trace and
Stack available if useful)?

Other than that I got:

reference at virtual address 00000070 printing eip: c0120095
*pde=00000000
Oops: 0
CPI=0
EIP: 0010:[<c0120095>] Not tainted
...

AND

<1> Unable to hande kernel NULL pointer dereference at virtual address
00000000 printing eip: c010ee96
*pde=00000000
Oops=0000
CPU=0
EIP: 0010:[<c010ee96>] Not tainted
...

AND

<0> Kernel panic: Aieee, killing interrupt controller!

Thanks!
