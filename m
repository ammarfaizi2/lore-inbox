Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbQLPQsA>; Sat, 16 Dec 2000 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbQLPQru>; Sat, 16 Dec 2000 11:47:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41996 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131633AbQLPQrn>; Sat, 16 Dec 2000 11:47:43 -0500
Subject: Re: Linux 2.2.19pre1
To: andrea@suse.de (Andrea Arcangeli)
Date: Sat, 16 Dec 2000 16:19:47 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20001216151303.D25150@inspiron.random> from "Andrea Arcangeli" at Dec 16, 2000 03:13:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147K3q-0002ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o	Basic page aging				(Neil Schemenauer)
> > 	| This is a beginning to trying to get the VM right
> 
> (page aging isn't a matter of correctness of the VM, it's only a matter of
> performance basically only during swap [for all other usages lru behaviour is
> enough])

'Getting the VM right' isnt just correctness although that is obviously 
extremely important. And getting it in early to find out how it behaves was
done because its hard to predict right now.

> For 2.2.19pre2 short term I'd suggest to backout the aging patch and to apply
> VM-global against 2.2.18. This will make VM behaviour better regardless
> of aging, then if you still feel the need of aging on your 486 8mbyte box
> I will try to put your patch on top of VM-global at least after addressing
> the swapcache shrinking issue and optimizing it a little bit.

Ok

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
