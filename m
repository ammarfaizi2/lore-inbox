Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRBHWto>; Thu, 8 Feb 2001 17:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbRBHWte>; Thu, 8 Feb 2001 17:49:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40206 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129321AbRBHWtP>; Thu, 8 Feb 2001 17:49:15 -0500
Subject: Re: Problems with 2.4.2-pre1 & reiser & vfs
To: mason@suse.com (Chris Mason)
Date: Thu, 8 Feb 2001 22:49:52 +0000 (GMT)
Cc: charta@gaumina.lt (Andrius Adomaitis), linux-kernel@vger.kernel.org
In-Reply-To: <1220580000.981671835@tiny> from "Chris Mason" at Feb 08, 2001 05:37:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Qzsx-0004wt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel: PAP-5660: reiserfs_do_truncate: wrong result -1 of search for 
> > [7906789 7906806 0xfffffffffffffff DIRECT]
> > .....
> 
> These aren't good at all, and show a general corruption problem.  I know the ac kernels have at least one small DAC960 bug fixes, are there other fixes pending?
> 

The dac960 changes relate to gcc 2.96 stuff and wouldnt account for real bugs.
DAC960 built with cvs gcc or 2.96 < 2.96-74 or so could do because of the ABI
thing but wouldnt boot that far. If its straight 2.4.1 suspect the elevator
corruption thing too

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
