Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292876AbSCEXiZ>; Tue, 5 Mar 2002 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293243AbSCEXiQ>; Tue, 5 Mar 2002 18:38:16 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:6412 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S292876AbSCEXiH>;
	Tue, 5 Mar 2002 18:38:07 -0500
Date: Wed, 6 Mar 2002 00:37:56 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.44.0203051525460.1475-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0203060032090.1113-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Davide Libenzi wrote:

> > I believe not all machine have  alignof  == sizeof
> 
> Yes but this is always true   alignof >= sizeof

No, this is not true. As the gcc info pages says: 
   For example, if the target machine requires a `double' value to be
   aligned on an 8-byte boundary, then `__alignof__ (double)' is 8.  This
   is true on many RISC machines.  On more traditional machine designs,
   `__alignof__ (double)' is 4 or even 2.
A later example shows situations where alignof>sizeof.


Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...



