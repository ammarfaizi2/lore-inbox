Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264812AbRF1Wum>; Thu, 28 Jun 2001 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbRF1Wuc>; Thu, 28 Jun 2001 18:50:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61713 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264825AbRF1Wtg>; Thu, 28 Jun 2001 18:49:36 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
To: davem@redhat.com (David S. Miller)
Date: Thu, 28 Jun 2001 23:48:53 +0100 (BST)
Cc: bcrl@redhat.com (Ben LaHaise), jes@sunsite.dk (Jes Sorensen),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <15163.45534.977835.569473@pizda.ninka.net> from "David S. Miller" at Jun 28, 2001 03:38:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Fkaj-0007nI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are so many issues with 64-bit DAC support, that many of
> the people whining in this thread have not even considered, and

Such as ? - I can see the obvious ones

-	Its slower
-	Not all host bridges can hit all of RAM
-	You want to use SAC and IOMMU when possible

> resources".  How do you say "SAC is preferred for performance" with
> ia64's API?  You can't.

I doubt they worried about it, SAC isnt terribly useful on IA64 right now.

> This, almost with several other issues, need to be considered and
> handled by whatever API you come up with.  If it does not address
> all of these issues somehow, it is unacceptable.

Nod

