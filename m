Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSFBWBD>; Sun, 2 Jun 2002 18:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSFBWBC>; Sun, 2 Jun 2002 18:01:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52696 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315430AbSFBWBB>;
	Sun, 2 Jun 2002 18:01:01 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15610.38211.645247.449007@argo.ozlabs.ibm.com>
Date: Mon, 3 Jun 2002 07:59:31 +1000 (EST)
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.19 IDE 78
In-Reply-To: <3CFA733F.4070907@evision-ventures.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>-	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
> >>+	ata_irq_enale(drive, 0);
> 
> For sure not. The nIEN bit is *negated* on the part of the
> device - please look at the ata_irq_enable() functions definition.
> I have explained it there.

Martin, that's a bit of your patch I was quoting.  I was just trying
to point out that you wrote "ata_irq_enale" instead of "ata_irq_enable".

Paul.
