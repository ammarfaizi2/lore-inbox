Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAIR3E>; Tue, 9 Jan 2001 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAIR2y>; Tue, 9 Jan 2001 12:28:54 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:10253 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129431AbRAIR2t>; Tue, 9 Jan 2001 12:28:49 -0500
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
To: mingo@elte.hu
Date: Tue, 9 Jan 2001 17:29:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sct@redhat.com (Stephen C. Tweedie),
        hch@caldera.de (Christoph Hellwig), davem@redhat.com (David S. Miller),
        riel@conectiva.com.br, netdev@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101091743090.5932-100000@e2> from "Ingo Molnar" at Jan 09, 2001 05:48:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14G2aT-00071v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ever seen, this is why i quoted it - the talk was about block-IO
> performance, and Stephen said that our block IO sucks. It used to suck,
> but in 2.4, with the right patch from Jens, it doesnt suck anymore. )

Thats fine. Get me 128K-512K chunks nicely streaming into my raid controller
and I'll be a happy man

I don't have a problem with the claim that its not the per page stuff and 
plugging that breaks ll_rw_blk. If there is evidence contradicting the SGI
stuff it's very interesting

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
