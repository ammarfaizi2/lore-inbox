Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288782AbSANSqE>; Mon, 14 Jan 2002 13:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSANSph>; Mon, 14 Jan 2002 13:45:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288784AbSANSoP>; Mon, 14 Jan 2002 13:44:15 -0500
Subject: Re: Hardwired drivers are going away?
To: esr@thyrsus.com
Date: Mon, 14 Jan 2002 18:56:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        babydr@baby-dragons.com (Mr. James W. Laferriere),
        cate@debian.org (Giacomo Catenazzi),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020114131050.E14747@thyrsus.com> from "Eric S. Raymond" at Jan 14, 2002 01:10:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QCH4-0002XB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that 20% being in the nasty complicated bits where the maintainability
> improvement will be greatest.  And I can get rid of the nasty "vitality"
> flag, which probably the worst wart on the language.
> 
> Yowza...so how soon is this supposed to happen?

Subject to availability. No contract implied or etc.. Its something to
tackle after the rest of initramfs works. Even if not then the lsmod case
can be made to work since its just a matter of putting the names in a segment
for the linker to collate.

We already have module_init/module_exit which is a big chunk of the cleanup.
