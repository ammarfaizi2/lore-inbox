Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272577AbRHaBUi>; Thu, 30 Aug 2001 21:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272578AbRHaBU2>; Thu, 30 Aug 2001 21:20:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38406 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272577AbRHaBUR>; Thu, 30 Aug 2001 21:20:17 -0400
Subject: Re: [PATCH] blkgetsize64 ioctl
To: Andries.Brouwer@cwi.nl
Date: Fri, 31 Aug 2001 02:23:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, linux-kernel@vger.kernel.org,
        michael_e_brown@dell.com, tytso@mit.edu
In-Reply-To: <200108310115.BAA318386@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at Aug 31, 2001 01:15:50 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cd1y-0002HR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> one needs (1) a test in ll_rw_blk.c that uses not the size in 1024-byte blocks
> but in 512-byte sectors, and (2) a set-blocksize ioctl.
> And this latter is needed for other reasons as well.
> 
> Maybe I should resubmit some such patch fragments?

If you can doit cleanly - yes
