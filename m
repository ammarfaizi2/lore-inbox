Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283579AbRLIQHy>; Sun, 9 Dec 2001 11:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283582AbRLIQHo>; Sun, 9 Dec 2001 11:07:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37903 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283579AbRLIQHZ>; Sun, 9 Dec 2001 11:07:25 -0500
Subject: Re: Linux 2.4.17-pre5
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Sun, 9 Dec 2001 16:16:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), anton@samba.org, davej@suse.de,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <E16CtEp-0007Jb-00@wagner> from "Rusty Russell" at Dec 09, 2001 12:58:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16D6cn-00071w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I trust Intels own labs over you on this one.
> This is voodoo optimization.  I don't care WHO did it.

Why don't you spend some time making the PPC64 port actually follow
basic things like the coding standard. Its not voodoo optimisation, its
benchmarked work from Intel.

> Given another chip with similar technology (eg. PPC's Hardware Multi
> Threading) and the same patch, dbench runs 1 - 10 on 4-way makes NO
> POSITIVE DIFFERENCE.

Well let me guess. Perhaps the PPC hardware MT is different. Real numbers
have been done. Getting uppity because we have HT code in that happens to
clash with your work isn't helpful. The fact that the IBM PPC64 port is
9 months behind in this area doesn't mean the rest of us can wait. When the
PPC64 port is usable, mergable and resembles actual Linux code then this
can be looked at again for 2.4.

Perhaps you'd like to submit your PPC64 HT patches to the list today
so that they can be tried comparitively on the Intel HT and we can see if
its a better generic solution ?

For 2.5 the scheduler needs a rewrite anyway so its a non issue there.

Alan
