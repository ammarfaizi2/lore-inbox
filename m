Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbREOJ4C>; Tue, 15 May 2001 05:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbREOJzw>; Tue, 15 May 2001 05:55:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54542 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262715AbREOJze>; Tue, 15 May 2001 05:55:34 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 15 May 2001 10:51:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        hpa@transmeta.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0105150532150.21081-100000@weyl.math.psu.edu> from "Alexander Viro" at May 15, 2001 05:49:08 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zbU2-0002IF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, if we are doing that we might as well use saner interface than
> ioctl(2). In case you've mentioned we don't want "make device SYS$FOO17
> do special action OP$LOUD$BARF4269". We want "make device rewind the tape".
> Or "tell us geometry". Or "eject the media". Application doesn't

Counter argument; We dont want the bloat of making a floppy tape have
delusions of grandeur in kernel space when mt-st can do it in userspace.

Alan

