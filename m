Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHBPOk>; Thu, 2 Aug 2001 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHBPOa>; Thu, 2 Aug 2001 11:14:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:28434 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268997AbRHBPOS>; Thu, 2 Aug 2001 11:14:18 -0400
Subject: Re: Re[2]: cannot copy files larger than 40 MB from CD
To: chrisv@b0rked.dhs.org (Chris Vandomelen)
Date: Thu, 2 Aug 2001 16:14:39 +0100 (BST)
Cc: nerijus@users.sourceforge.net (Nerijus Baliunas),
        dwguest@win.tue.nl (Guest section DW), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0107311656420.10245-100000@linux.local> from "Chris Vandomelen" at Jul 31, 2001 04:58:06 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SKBL-0000qt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tried vfat, ext2 and reiserfs.
> >
> > BTW, kernel is compiled with gcc-2.96-85, glibc-2.2.2-10 (RH 7.1) if
>                                ^^^^^^^^^^^
> > that matters.
> 
> Have you tried compiling your kernel using kgcc?
> 
> gcc-2.96.* is known to compile code incorrectly AFAIK, and shouldn't be
> used for compiling kernels. (kgcc is egcs-1.1.2, I think.)

[x86 hat on]

egcs-1.1.2 aka kgcc wont build 2.4.7 it seems. gcc 2.96 >= 2.96.75 or so is
just fine, gcc 2.95-2/3 is fine, gcc 3.0 seems to be doing the right thing
