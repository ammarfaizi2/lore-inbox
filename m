Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136072AbRDVMbX>; Sun, 22 Apr 2001 08:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136071AbRDVMbO>; Sun, 22 Apr 2001 08:31:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37391 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136072AbRDVMbE>; Sun, 22 Apr 2001 08:31:04 -0400
Subject: Re: [kbuild-devel] Re: Request for comment -- a better attribution
To: cate@dplanet.ch (Giacomo A. Catenazzi)
Date: Sun, 22 Apr 2001 13:32:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), esr@thyrsus.com,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <3AE2B847.C4EE45E9@dplanet.ch> from "Giacomo A. Catenazzi" at Apr 22, 2001 12:53:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJ2j-0005jf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where developers should send patches? To Linus/AC or to driver
> maintainer?

All of the above at random. Sometimes with a cc. Often to me/Linus if the
maintainer isnt responding.

> ESR proposal enforces this last, but do all mainainers have always time
> for linux
> developement? Should the maintainers be professional? Should Linus/AC
> reject
> clean patches from non-maintainers? Do all maintainers read lkml?

The scheme I work tends to be something like


If the patch is small and obviously correct and its not to Jes Sorensen's driver
	Apply it to -ac

If the patch is more complex or changes design considerations
	if it seems reasonably sane to apply
		Apply to -ac
		Cc change to maintainer
		Mark not to go to Linus without maintainer approval
	Bounce to maintainer if active
	Apply if not active or not replying

If the patch changes fundamental things - eg syscall numbers, policy in kernel
	Tell them to talk to Linus

And then there are a thousand specific other things like config.h include fixing
typo fixes and such which don't quite follow the rule.

