Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbTATQ4b>; Mon, 20 Jan 2003 11:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266535AbTATQ4b>; Mon, 20 Jan 2003 11:56:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60300 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266552AbTATQ4a>; Mon, 20 Jan 2003 11:56:30 -0500
Date: Mon, 20 Jan 2003 12:07:52 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: egcs (or compatible) compiler
Message-ID: <Pine.LNX.3.95.1030120114634.18629A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to find the "latest and greatest" gcc compiler that
will compile the kernel. I can't find the source anywhere!
Apparently, gnu doesn't "do" the compiler anymore, it's now
called egcs and is supposed to be on goof.com according to
the links from the GCC home page. They only have patches.
The last source-code I have been able to find for gcc is
gcc-3.0.1.tar.gz and it won't even compile under egcs-2.9.1.66
(which I installed about a year ago before it became unavailable
and dissappeared).

So, what gives? Any hints on how I get the source of the most
recommended gcc, that will actually compile on a previous version
of gcc? I'm presently using egcs-2.9.1.66, but newer kernels won't
compile using it. They fail to link with "__rawmemchr" errors, i.e.,
caused by code that gets the string-length by doing strchr(s, 0),
i.e., looks for the null. This envokes some __rammemchr() function
that doesn't exist.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


