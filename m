Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136082AbREGKu1>; Mon, 7 May 2001 06:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbREGKuQ>; Mon, 7 May 2001 06:50:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21768 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136082AbREGKuC>; Mon, 7 May 2001 06:50:02 -0400
Subject: Re: page_launder() bug
To: tori@tellus.mine.nu (Tobias Ringstrom)
Date: Mon, 7 May 2001 11:52:26 +0100 (BST)
Cc: davem@redhat.com (David S. Miller),
        chromi@cyberspace.org (Jonathan Morton),
        szabi@inf.elte.hu (BERECZ Szabolcs), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus> from "Tobias Ringstrom" at May 07, 2001 08:26:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14wicu-0003L5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
> 
> But is it really specified in the C "standards" to be exctly zero or one,
> and not zero and non-zero?

Yes. (Fortunately since when this argument occurred Linus said he would eat
his underpants if he was wrong)

Alan

