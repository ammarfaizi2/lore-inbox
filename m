Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDA2w>; Fri, 3 Nov 2000 19:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDA2m>; Fri, 3 Nov 2000 19:28:42 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:7586 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129033AbQKDA2h>; Fri, 3 Nov 2000 19:28:37 -0500
Message-ID: <3A03665B.91266A06@didntduck.org>
Date: Fri, 03 Nov 2000 20:28:59 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86 boot time check for cpu features
In-Reply-To: <E13rr7a-00046v-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Alan Cox wrote:
> > > Q:      are any of the things you test present in processors only after we
> > >         do magic 'cpuid' enable invocations ?
> >
> > Hmm, after a bit more investigation, it appears that the Cyrix MII
> > processors support cmov instructions, even though we currently don't
> > compile for that processor with -march=i686.  Please ignore this patch
> > until I can come up with something better.
> 
> I believe the MII always has CPUID enabled. It was the older Cyrixes that did
> not. DaveJ is the guru..

Well, according to comments in bugs.h, some broken BIOSes disable cpuid.

--

					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
