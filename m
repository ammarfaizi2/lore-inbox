Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129348AbQKWWqN>; Thu, 23 Nov 2000 17:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129401AbQKWWqD>; Thu, 23 Nov 2000 17:46:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8224 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129348AbQKWWps>; Thu, 23 Nov 2000 17:45:48 -0500
Subject: Re: VMWare will not run on kernel 2.4.0-test11
To: VANDROVE@vc.cvut.cz (Petr Vandrovec)
Date: Thu, 23 Nov 2000 22:15:37 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux-KERNEL)
In-Reply-To: <DB4EB260F6F@vcnet.vc.cvut.cz> from "Petr Vandrovec" at Nov 23, 2000 10:29:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13z4eY-0007pa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   is change to field name temporary, and name will be reverted back
> to flags, even although contents may differ between 2.2.x and 2.4.x,
> or is there features to stay? Currently VMware does
> 
> "^\(features\|flags\).* tsc"
> 
> but question is - should we leave it here, or revert it back?

I believe we should change it back. Until Linus makes a decision then I
dont think its final by any means.

features breaks stuff, flags seems not to

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
