Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276097AbRI1O7U>; Fri, 28 Sep 2001 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276099AbRI1O7J>; Fri, 28 Sep 2001 10:59:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2567 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276097AbRI1O7D>; Fri, 28 Sep 2001 10:59:03 -0400
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
To: timm@fnal.gov (Steven Timm)
Date: Fri, 28 Sep 2001 16:04:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0109280929030.30363-100000@snowball.fnal.gov> from "Steven Timm" at Sep 28, 2001 09:53:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mzBY-0007JX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> serverworks.c which was in the 2.4.6-ac series now propagated
> into Linus' tree (and eventually into the RedHat tree?)  Also,
> are the later 2.4.7 and higher -ac patches significantly
> different from that which was found in the 2.4.6-ac patches?

Most vendor are -ac based. The IDE changes in Linus tree match the 
Andre code with my fixes for the Dell cable detect. The -ac tree contains
an additional trap for the seagate problem we are chasing but is otherwise
the same

> Just tell me what you think your latest and greatest patch is that
> you would want to see tested and I'll be glad to give it a test on this
> cluster.

The extra trap in the -ac tree may be useful as it should trigger on the
seagate problem. If you can pull a box out of service I have a test set from
an RH customer with this problem that replicates the UDMA problem remarkably
reliably and rapidly for them (but not on serverworks own tests so its
not a simple problem). It would be useful to know if the seagate problem is
replicable and shows up the same way on your boxen

Info on the precise seagate drives, and pci data on the machines would be
very useful too so I can compare it to the other case and also pass it on
to serverworks.

Alan
