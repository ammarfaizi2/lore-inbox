Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbRBDLE3>; Sun, 4 Feb 2001 06:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130609AbRBDLET>; Sun, 4 Feb 2001 06:04:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30990 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130277AbRBDLEN>; Sun, 4 Feb 2001 06:04:13 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: leitner@convergence.de (Felix von Leitner)
Date: Sun, 4 Feb 2001 11:04:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010204002627.A9527@convergence.de> from "Felix von Leitner" at Feb 04, 2001 12:26:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PMyK-0001N4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > can bracket his code in 'if [ $TRUSTED = "y" ] ... fi', so if some driver-fs
> > fails with untrusted compilers it is just not selectable.
> 
> What kind of crap is this?
> It is not the kernel's job to work around RedHat bugs.

The kernel actually works round gcc 2.7.2, egcs-1.1.2 and gcc-2.95 bugs, but
in this case having some CONFIG option and all the glue for it isnt right
especially because there _is_ a fixed compiler and the documentation tells
you to use 1.1.2 or 2.95 anyway
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
