Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264808AbRFSV7h>; Tue, 19 Jun 2001 17:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbRFSV72>; Tue, 19 Jun 2001 17:59:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15635 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264810AbRFSV7H>; Tue, 19 Jun 2001 17:59:07 -0400
Subject: Re: Linux 2.2.20-pre4
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 19 Jun 2001 22:57:42 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        kloczek@rudy.mif.pg.gda.pl (Tomasz =?iso-8859-1?Q?K=B3oczko?=),
        laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B2FC899.3F0105F1@mandrakesoft.com> from "Jeff Garzik" at Jun 19, 2001 05:48:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15CTVG-0006o0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO omitting -fno-builtin when compiling the kernel was always a risky
> proposition...  Since we provide our own copies of many of the builtins
> [which are used in the kernel] anyway... why not always -fno-builtin,
> and then call __builtin_foo when we really want the compiler's version..

That may well be the right thing to do. Of course we rely on the compiler
providing some of them too

> gcc 3.0 without -fno-builtin is perfectly allowed to assume it can
> insert calls to memcpy..

I have no argument about its correctness there, but -fno-builtin will still
give a kernel that dosnt link due to abs() and other problems.. 8)

