Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUBPDh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 22:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265334AbUBPDhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 22:37:55 -0500
Received: from topaz.cx ([66.220.6.227]:49344 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S265333AbUBPDhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 22:37:50 -0500
Date: Sun, 15 Feb 2004 22:37:40 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Message-ID: <20040216033740.GE3789@perlsupport.com>
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40302783.6020505@pobox.com>
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jeff Garzik:
> Really the best policy IMO is just to run 'e2fsck -c' every so often 
> until you can get your data off this disk, and throw it in the garbage. 
> That does the "remapping" at the filesystem level, which is IMO easier 
> than bothering with low-level ATA commands.

Good advice, though I have to find the XFS equivalent.

Still: I wonder if the occasional bad sector is really that bad.
Shirley, at the unreal densities of today's drives, the development of
bad sectors is inevitable?  (Especially in a laptop drive that's
bounced around in normal use.)
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
