Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129851AbQKPWKL>; Thu, 16 Nov 2000 17:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQKPWJv>; Thu, 16 Nov 2000 17:09:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129851AbQKPWJj>; Thu, 16 Nov 2000 17:09:39 -0500
Subject: Re: Linux 2.2.18pre21
To: jesse@wirex.com (jesse)
Date: Thu, 16 Nov 2000 21:40:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001116115249.A8115@wirex.com> from "jesse" at Nov 16, 2000 11:52:49 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wWlX-0008Oh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's simply not good enough to close all directory file descriptors before chrooting.
> 
> If calling chroot once you're already in a chroot jail was disallowed, it would stop
> this attack.

I think the problem here is that some people have the idea that chroot is 
some kind of magical security device. Thats not true at all. You can build an
environment like that if you wish by closing other directory handles and having
no suitably priviledged code in the chroot area and stuff.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
