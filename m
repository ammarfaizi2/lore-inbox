Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLDUuX>; Mon, 4 Dec 2000 15:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129314AbQLDUuN>; Mon, 4 Dec 2000 15:50:13 -0500
Received: from sirocco.CC.McGill.CA ([132.206.27.12]:59872 "EHLO
	sirocco.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id <S129183AbQLDUuD>; Mon, 4 Dec 2000 15:50:03 -0500
Date: Mon, 4 Dec 2000 15:18:09 -0500 (EST)
From: Felix Braun <fbraun@atdot.org>
Reply-To: fbraun@atdot.org
To: linux-kernel@vger.kernel.org
Subject: autoloading of lowlevel modules broken (devfs-related?)
Message-ID: <Pine.LNX.4.21.0012041505560.566-100000@eressea.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've had some strange problems with autoloading of some modules in the
latest versions of the kernel (up to test12-pre4). I'm using devfs and
modutils 2.3.21. Most of the modules autoload fine however ppp_async and
parport_pc don't autoload anymore. /etc/modules.conf has the following
aliases:
alias char-major-108 ppp_generic
alias tty-ldisc-3    ppp_async
alias parport_lowlevel parport_pc

Everything worked fine with that setup until 2.4.0-test8. If I insmod the
modules by hand things continue to run smoothly.

Is there an obvious problem that I have missed? Does anybody else have
these problems? Can anybody help me?

Thanks a lot in advance... Felix

PS: please cc me directly

--
Felix Braun
1910 rue Wellington
Montreal PQ
Canada H3K 1W3
Tel: ++1-514-933 60 58

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
