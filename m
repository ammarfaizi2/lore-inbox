Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281895AbRLLU1r>; Wed, 12 Dec 2001 15:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281887AbRLLU1h>; Wed, 12 Dec 2001 15:27:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6530 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281895AbRLLU1Y>; Wed, 12 Dec 2001 15:27:24 -0500
Date: Wed, 12 Dec 2001 15:27:19 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: name-server in the kernel
Message-ID: <Pine.LNX.3.95.1011212151834.29042A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I deleted the name of the one who made the query. Of course
you could do the M$ way (bad network neighbor). You have the
routing information from within the kernel. Therefore, you
can query every possible address on port 53. This will eventually
get you some machine that pretends to be a name-server for the
domain.

I don't suggest you do this, though.  If you need IP addresses
or name-to-address translation inside a module or a kernel-driver,
something is broken in the design, probably an understanding of
what the kernel is.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


