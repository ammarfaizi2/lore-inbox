Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbTAMIQb>; Mon, 13 Jan 2003 03:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAMIQb>; Mon, 13 Jan 2003 03:16:31 -0500
Received: from hancock.siteprotect.com ([64.41.120.29]:17082 "EHLO
	hancock.siteprotect.com") by vger.kernel.org with ESMTP
	id <S261836AbTAMIQa>; Mon, 13 Jan 2003 03:16:30 -0500
Date: Mon, 13 Jan 2003 02:25:02 -0600
From: Dee <dfisher@uptimedevices.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nervous with 2.4.21-pre3 and -pre3-ac*
Message-Id: <20030113022502.01ba079b.dfisher@uptimedevices.com>
In-Reply-To: <1042402716.16288.4.camel@irongate.swansea.linux.org.uk>
References: <20030112185500.6157F475C9@bellini.mit.edu>
	<1042402716.16288.4.camel@irongate.swansea.linux.org.uk>
Organization: Uptime Devices
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 2003-01-12 at 18:55, ghugh Song wrote:
> > Does anyone have any guess?


	I have this same problem with segfaulting and locks.
I did get this in the log once tho before a hang.

Jan 12 15:51:37 ghost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004 
Jan 12 15:51:37 ghost kernel: *pde = 00000000 
Jan 12 15:51:37 ghost last message repeated 2 times
Jan 12 15:51:38 ghost gpm[142]: oops() invoked from gpm.c(147)
Jan 12 15:51:38 ghost gpm[142]: /dev/vc/0: Input/output error

I also had it hang once when doing a ls on the dev dir aswell.
I am using devfs with debug and auto mount.
Ld seems to mess with it too, it hung twice in a row when
making the piggy.o on a make bzImage, on the pre3-ac3
kernel. Third time it went without a problem. Thought this might help.


					Dee

