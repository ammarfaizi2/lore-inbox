Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136433AbREDPuu>; Fri, 4 May 2001 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136437AbREDPuk>; Fri, 4 May 2001 11:50:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40973 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136433AbREDPuf>; Fri, 4 May 2001 11:50:35 -0400
Subject: Re: Possible PCI subsystem bug in 2.4
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 4 May 2001 16:52:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <m1hez1nmtc.fsf@frodo.biederman.org> from "Eric W. Biederman" at May 04, 2001 09:41:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vhsG-0007Xe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are a couple of options here.
> 1) read the MTRRs unless the BIOS is braindead it will set up that area as
>    write-back.  At any rate we shouldn't ever try to allocate a pci region
>    that is write-back cached.

'unless the BIOS is braindead'. Right. We only got into this problem because
the BIOS _was_ braindead.

Alan

