Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282402AbRLDIzh>; Tue, 4 Dec 2001 03:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282679AbRLDIz2>; Tue, 4 Dec 2001 03:55:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282402AbRLDIzU>; Tue, 4 Dec 2001 03:55:20 -0500
Subject: Re: i810 audio patch
To: nbryant@optonline.net (Nathan Bryant)
Date: Tue, 4 Dec 2001 09:03:56 +0000 (GMT)
Cc: dledford@redhat.com (Doug Ledford),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3C0C5CB2.6000602@optonline.net> from "Nathan Bryant" at Dec 04, 2001 12:18:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBUa-0001J0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So there may be some VM/buffer related problem lurking under the covers 
> still. Originally the oops popped up in kswapd, for me, but I can't 
> trigger it again.

I've seen multiple reports of random kswapd oopses in 2.4.16 so while it
could be that the i810 code introduced a bug its also quite possible you hit
an underlying flaw

Alan
