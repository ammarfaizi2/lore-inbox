Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132105AbQKDAYC>; Fri, 3 Nov 2000 19:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDAXv>; Fri, 3 Nov 2000 19:23:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbQKDAXj>; Fri, 3 Nov 2000 19:23:39 -0500
Subject: Re: [PATCH] x86 boot time check for cpu features
To: bgerst@didntduck.org (Brian Gerst)
Date: Sat, 4 Nov 2000 00:23:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <3A034588.4E06D5FC@didntduck.org> from "Brian Gerst" at Nov 03, 2000 06:08:56 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rr7a-00046v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > Q:      are any of the things you test present in processors only after we
> >         do magic 'cpuid' enable invocations ?
> 
> Hmm, after a bit more investigation, it appears that the Cyrix MII
> processors support cmov instructions, even though we currently don't
> compile for that processor with -march=i686.  Please ignore this patch
> until I can come up with something better.

I believe the MII always has CPUID enabled. It was the older Cyrixes that did
not. DaveJ is the guru..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
