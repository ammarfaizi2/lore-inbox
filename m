Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBCHnU>; Sat, 3 Feb 2001 02:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBCHnK>; Sat, 3 Feb 2001 02:43:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129027AbRBCHnB>; Sat, 3 Feb 2001 02:43:01 -0500
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 3 Feb 2001 07:42:59 +0000 (GMT)
Cc: jocelyn.mayer@netgem.com (Jocelyn Mayer), linux-kernel@vger.kernel.org
In-Reply-To: <10847.981156339@ocs3.ocs-net> from "Keith Owens" at Feb 03, 2001 10:25:39 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OxLa-0007xv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel source is broken as designed.  /usr/include/{linux,asm} must be
> real directories that are shipped as part of glibc, not symlinks to
> some random version of the kernel.  Fix /usr/include.

You need to fix the kernel headers too - libc5 doesnt work otherwise
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
