Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131872AbQLJTCj>; Sun, 10 Dec 2000 14:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131950AbQLJTC3>; Sun, 10 Dec 2000 14:02:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57353 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131872AbQLJTCT>; Sun, 10 Dec 2000 14:02:19 -0500
Subject: Re: Serial cardbus code.... for testing, please.....
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 10 Dec 2000 18:32:34 +0000 (GMT)
Cc: tytso@MIT.EDU (Theodore Y. Ts'o), torvalds@transmeta.com (Linus Torvalds),
        rgooch@ras.ucalgary.ca, jgarzik@mandrakesoft.mandrakesoft.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A33B06A.84ED5D58@mandrakesoft.com> from "Jeff Garzik" at Dec 10, 2000 11:33:46 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E145BH3-0006ph-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW I don't think you should sit on fixes until post 2.4.0...  and I
> would like to get CardBus serial working because it's broken in the
> current tree...

I would agree. Right now serial cardbus is broken, line discipline race patches
dont appear to have been applied and these are serious enough to definitely
want fixing, either with your patch or someone else doing the work instead.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
