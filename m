Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRBGTCn>; Wed, 7 Feb 2001 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbRBGTCd>; Wed, 7 Feb 2001 14:02:33 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32005 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130004AbRBGTCS>; Wed, 7 Feb 2001 14:02:18 -0500
Subject: Re: PCI-SCI Drivers v1.1-7 released
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 7 Feb 2001 19:02:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010207111345.D27089@vger.timpanogas.org> from "Jeff V. Merkey" at Feb 07, 2001 11:13:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QZrI-00012X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hummm.  Where are the patches for 2.4 to correct this?  They are not posted
> with the 7.1 release.  They need to be.  The compiler not supporting 

They don't need to be because the thing is just a warning. The kernel has
plenty of warnings and this one is 100% harmless.

> #ident for CVS is a show stopper, and needs correcting ASAP.  How can 
> someone use CVS properly with this, Alan?

Im using CVS all the time. Im not sure what the #ident thing would be. But
then like everyone else I know I use $ident in comments. JJ will probably
be glad to work on that one

Right now I'm down to one known problem with 2.96 and 2.4.x kernels - which
is that CVS gcc and 2.96 accidentally changed the ABI and broke the bitfield
assumptions in DAC960.c/h. JJ I believe just committed patches for that one

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
