Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263557AbRFLVt0>; Tue, 12 Jun 2001 17:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263567AbRFLVtG>; Tue, 12 Jun 2001 17:49:06 -0400
Received: from [216.101.162.242] ([216.101.162.242]:30111 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S263557AbRFLVtB>;
	Tue, 12 Jun 2001 17:49:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.36346.932239.542996@pizda.ninka.net>
Date: Tue, 12 Jun 2001 14:47:38 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bob McElrath <rsmcelrath@students.wisc.edu>,
        Jeff Golds <jgolds@resilience.com>, Wakko Warner <wakko@animx.eu.org>,
        Pierfrancesco Caci <p.caci@seabone.net>, linux-kernel@vger.kernel.org
Subject: Re: es1371 and recent kernels
In-Reply-To: <3B268CF6.5197EA21@mandrakesoft.com>
In-Reply-To: <873d95lnqr.fsf@paperino.int-seabone.net>
	<20010612111503.A870@draal.physics.wisc.edu>
	<20010612164204.A21504@animx.eu.org>
	<3B2681A8.567992F6@resilience.com>
	<20010612163150.C16885@draal.physics.wisc.edu>
	<3B268CF6.5197EA21@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > > Argh, I had one of those, gave it away because it would hang my alpha
 > > hard (I'm told the card is pretty nonconformant to the PCI spec).
 > > *sigh*
 > 
 > Now you tempt me to find this card and fix the alpha problem :)

I get instant master aborts on Sparc64 with the es1371, but I think
this is because the card recognizes less than the full 32-bits of
address lines on PCI.

So the thing is basically useless to me, and I believe the alpha
platform issues have to do with es1371's bogus handling of some WRITE
pci transactions.

Later,
David S. Miller
davem@redhat.com
