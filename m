Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271701AbRH0K5A>; Mon, 27 Aug 2001 06:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271702AbRH0K4u>; Mon, 27 Aug 2001 06:56:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8709 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271701AbRH0K4n>; Mon, 27 Aug 2001 06:56:43 -0400
Subject: Re: Linux 2.4.8-ac12
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Mon, 27 Aug 2001 12:00:16 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010827093529.A31359@emma1.> from "Matthias Andree" at Aug 27, 2001 09:35:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bK7s-0003iU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.9 is somewhat stable for me, here's where it bit me:
> 
> - init occasionally hangs on boot

Seen that too.

> - bridge (with netfilter patches from bridge.sf.net) kills NFS (I have
>   been told bridge and fragmented traffic don't go together well and I'd
>   have to change rsize/wsize to prevent fragmentation)
> 
> Is 2.4.8-ac12 "testable" or rather "stable"?

That sounds like your bridge cards lack enough buffering or can't cope with
back to back frames. This bites people who use 8K buffer ISA cards in 
paticular.

-ac12 should be pretty solid. Im about to put out 2.4.9-ac1 which is 
more experimental, although it has run all night, something 2.4.9 never 
managed
Alan

