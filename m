Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130575AbQKKMXk>; Sat, 11 Nov 2000 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130648AbQKKMXb>; Sat, 11 Nov 2000 07:23:31 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:31577 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S130575AbQKKMXV>; Sat, 11 Nov 2000 07:23:21 -0500
Date: Sat, 11 Nov 2000 14:31:08 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: root <whtdrgn@mail.cannet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17 wont compile on AMD k6@-550
In-Reply-To: <3A0C9B74.114053B6@cannet.com>
Message-ID: <Pine.LNX.4.21.0011111430330.7262-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, root wrote:

> Hello kernel hackers,
> 
>     I am having problems with compiling a kernel on an AMD K62-550.
> I am running Red Hat 6.2, and am getting error messages like this:
> 
> cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
> -fomit-frame-pointer -fno-strict-aliasing -pipe -fno-strength-reduce
> -m486 -malign-loops=2 -malign-jumps=2 -malign-functions=2 -DCPU=686   -c
> -o tcp_output.o tcp_output.c
> cc: Internal compiler error: program cc1 got fatal signal 11

SIG11 is almost always a hardware problem. Read the SIG11-HOWTO (is that
called that way ?)

> Kind Regards
> Timothy A. DeWees


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
