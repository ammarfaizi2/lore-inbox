Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGJjT>; Wed, 7 Feb 2001 04:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGJjK>; Wed, 7 Feb 2001 04:39:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129028AbRBGJi7>; Wed, 7 Feb 2001 04:38:59 -0500
Subject: Re: RedHat kernel RPM 2.2.16
To: jroland@roland.net (Jim Roland)
Date: Wed, 7 Feb 2001 09:39:09 +0000 (GMT)
Cc: jdow@earthlink.net (J. Dow), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10102062344490.31995-100000@ns.roland.net> from "Jim Roland" at Feb 06, 2001 11:50:16 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14QR4C-0008EY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I appreciate your comments, but the SOURCE is exactly what I am needing in
> order to compile in PCTel modem support.  FYI, I'm not a newbie, so I do

You want the kernel-source*rpm package. That provides a copy of the source
tree in the typical Linus format (unpacked in /usr/src/linux)

> did not execute.  This occurs on an RH7 system as well.  Seems to be
> something wrong with RH's kernel rpm?

Nope. The source rpm is for building kernels in rpm format. It does exactly
that. You could add your patches to the rpm build and build an rpm format
kernel but thats a less trivial exercise and one that is perhaps not so
well understood by most of the folks who can help you

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
