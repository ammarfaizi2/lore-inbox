Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRDBX3b>; Mon, 2 Apr 2001 19:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131555AbRDBX3W>; Mon, 2 Apr 2001 19:29:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131478AbRDBX3S>; Mon, 2 Apr 2001 19:29:18 -0400
Subject: Re: Kernel 2.4.3 fails to compile
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 3 Apr 2001 00:30:32 +0100 (BST)
Cc: mmt@unify.com (Manuel A. McLure),
   linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <Pine.LNX.3.96.1010330133901.8826V-100000@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Mar 30, 2001 01:39:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kDmM-0006sg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > buz.c: In function `v4l_fbuffer_alloc':
> > buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
> > buz.c:188: (Each undeclared identifier is reported only once
> > buz.c:188: for each function it appears in.)
> 
> Easy solution -- just delete the entire test
> 
> 	if (size > KMALLOC_MAXSIZE) {
> 		...
> 	}

Or use the -ac driver, or better yet use the new zoran driver in -ac, since
buz.c doesnt actually work in any 2.4 tree in either  vanilla or -ac.
