Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293243AbSCEXrf>; Tue, 5 Mar 2002 18:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293489AbSCEXrZ>; Tue, 5 Mar 2002 18:47:25 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6664 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S293243AbSCEXrJ>; Tue, 5 Mar 2002 18:47:09 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 5 Mar 2002 15:50:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Peter Svensson <petersv@psv.nu>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <Pine.LNX.4.33.0203060032090.1113-100000@cheetah.psv.nu>
Message-ID: <Pine.LNX.4.44.0203051549220.1475-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2002, Peter Svensson wrote:

> On Tue, 5 Mar 2002, Davide Libenzi wrote:
>
> > > I believe not all machine have  alignof  == sizeof
> >
> > Yes but this is always true   alignof >= sizeof
>
> No, this is not true. As the gcc info pages says:
>    For example, if the target machine requires a `double' value to be
>    aligned on an 8-byte boundary, then `__alignof__ (double)' is 8.  This
>    is true on many RISC machines.  On more traditional machine designs,
>    `__alignof__ (double)' is 4 or even 2.
> A later example shows situations where alignof>sizeof.

Yes, it's true.



- Davide



