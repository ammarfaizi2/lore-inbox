Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132392AbRDCR77>; Tue, 3 Apr 2001 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDCR7t>; Tue, 3 Apr 2001 13:59:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132392AbRDCR7k>; Tue, 3 Apr 2001 13:59:40 -0400
Subject: Re: The 53c400a
To: clock@ghost.btnet.cz
Date: Tue, 3 Apr 2001 19:01:29 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010403195208.A12046@ghost.btnet.cz> from "clock@ghost.btnet.cz" at Apr 03, 2001 07:52:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kV7T-00006w-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a) my 53c400 card must be initialized first by DOS driver to be detected by Linux kernel

Ok I've not needed that for mine. Must be a variant init function is used on
yours.

> b) The scanner initialization lasts about 4 minutes. And scanning is very slow
> even if I increase the kernel buffer to the max. as described in the SANE doc.

That sounds like a bug - takes about 9 seconds for me

> c) Using an adaptec SCSI adapter works just fine: scanner initializes
> immediately, card is recognized even without DOS and the scanning is much
> faster.

Yes - I keep meaning to move mine to a real scsi controller

