Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129396AbRBILtQ>; Fri, 9 Feb 2001 06:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBILsn>; Fri, 9 Feb 2001 06:48:43 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:48906 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129035AbRBILsc>;
	Fri, 9 Feb 2001 06:48:32 -0500
Date: Fri, 9 Feb 2001 12:47:28 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: ARND BERGMANN <std7652@et.FH-Osnabrueck.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epic100 in current -ac kernels
Message-ID: <20010209124728.A28045@se1.cogenit.fr>
In-Reply-To: <20010208162030.A9703@se1.cogenit.fr> <Pine.GSO.4.21.0102081714160.15579-100000@gamma10>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.21.0102081714160.15579-100000@gamma10>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARND BERGMANN <std7652@et.FH-Osnabrueck.DE> écrit :
> On Thu, 8 Feb 2001, Francois Romieu wrote:
> 
> > > 
> > > Working epic100 drivers:
> > >  - 2.4.0
> > >  - 2.4.0-ac9
> > 
> > Could you give a look at ac12 (fine here) ?
> > 
> No, does not work, same problem.

The modifications between ac9 and ac12 come from the new DMA 
mapping. They added a bug for the (already buggy ?) big-endian
machines. I would be surprised that something has *always* been 
missing in the driver and your hardware triggers it*. IMHO the culprit 
is to be found elsewhere.
I'd like to know what it's worth to share an irq with a pio audio card.

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
