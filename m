Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRDJQ15>; Tue, 10 Apr 2001 12:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132419AbRDJQ1r>; Tue, 10 Apr 2001 12:27:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29702 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132416AbRDJQ1j>; Tue, 10 Apr 2001 12:27:39 -0400
Subject: Re: Garbage-collection patches for Configure.help
To: esr@snark.thyrsus.com (Eric S. Raymond)
Date: Tue, 10 Apr 2001 17:29:01 +0100 (BST)
Cc: torvalds@transmeta.com, axel@uni-paderborn.de,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104101453.f3AErkq30339@snark.thyrsus.com> from "Eric S. Raymond" at Apr 10, 2001 10:53:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n10q-0004Yq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Auditing of the CML1 configuration system reveals that the following entries
> in Configure.help are orphans -- that is, they correspond to configuration
> symbols not in use in 2.4.3.  

Please dont use 2.4.3 for verifying these long term. Its woefully out of date
for non x86 ports and many of the entries may well be due to this (eg
HOST_FOOTBRIDGE ARCH_EBSA285 etc)

Im currently working on getting the arch stuff ready to merge with Linus and
this patch will just make it a nightmare.

