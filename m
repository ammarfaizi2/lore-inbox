Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266181AbRGEDTv>; Wed, 4 Jul 2001 23:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266584AbRGEDTl>; Wed, 4 Jul 2001 23:19:41 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:49097 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266181AbRGEDTb>; Wed, 4 Jul 2001 23:19:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rbultje@ronald.bitfreak.net (Ronald Bultje),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <E15HsKg-0001Pk-00@the-village.bc.nu>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 04 Jul 2001 23:16:43 -0400
In-Reply-To: Alan Cox's message of "Wed, 4 Jul 2001 20:29:06 +0100 (BST)"
Message-ID: <m2sngc3w10.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >> I'm kind of astounded now, WHY can't linux-2.4.x run on ANY
 >> machine in my house with more than 128 MB RAM?!? Can someone
 >> please point out to me

 Alan> Can I suggest you change your memory vendor and/or get an
 Alan> antistatic wrist strap ?

I also have had problems with a machine that had 128Mb + 64 Mb.  I
discovered the following about 2.4.x.  You _should_ have a swap file
that is double RAM.  Mixing different SDRAM types is probably a bad
thing.  So if you upgraded, then that might be problematic.

However, when I did have 196 Mb it completely trashed my file system.
I also work with electronic components and these were handled in an
ESD safe manner.  It may be possible to set the SDRAM controller to
handle disparate SDRAM chips...but it is probably very painful.  I
have done this on an MPC860 and a Coldfire chip.  However, I haven't
the faintest clue about PC controllers.

Perhaps when I am feeling brave again, I will return to try additional
memory.

hth,
Bill Pringlemeir.


