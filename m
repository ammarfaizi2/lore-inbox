Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSGaXNN>; Wed, 31 Jul 2002 19:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSGaXNN>; Wed, 31 Jul 2002 19:13:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38653 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318538AbSGaXNM>; Wed, 31 Jul 2002 19:13:12 -0400
Subject: Re: [2.6] The List, pass #2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: trond.myklebust@fys.uio.no
Cc: Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <15688.18891.446678.320123@charged.uio.no>
References: <3D3761A9.23960.8EB1A2@localhost>
	<Pine.LNX.3.96.1020731133038.10066A-100000@gatekeeper.tmr.com>
	<20020731185850.A20614@infradead.org> <shsk7nbps2u.fsf@charged.uio.no>
	<20020731212308.A23828@infradead.org> 
	<15688.18891.446678.320123@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:31:44 +0100
Message-Id: <1028161904.13048.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 21:34, Trond Myklebust wrote:
> Care to comment on why it is not GPL compatible? Given that they are
> interested in merging their code into the standard kernel ASAP, I know
> that they'd be interested in correcting any incompatibilities.

The 3 clause BSD though very much a completely free/open license has
requirements conflicting with the GPL 

http://www.fsf.org/licenses/license-list.html#GPLIncompatibleLicenses
http://www.fsf.org/philosophy/bsd.html

An additional problem with a BSD like license is that it makes no
statement on patents - regrettably a critical issue now days in the
USSA. That means nothing prevents CITI from providing BSD licensed code
and then 6 months later sueing everyone who used it. I don't see CITI
doing that but the basic problem is still there.

If it is all their own code, and they want to have a BSD licensed copy
for other reasons - eg to merge the same code into BSD, sell it to
proprietary vendors or whatever, then it would be immensely saner if
they would submit a copy for the Linux kernel under the GPL and keep it
dual licensed. As the owner of a work they can license it many many ways
all at the same time.

The random driver has a nice example of this.

Alan

