Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268127AbTBSAxU>; Tue, 18 Feb 2003 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268128AbTBSAxT>; Tue, 18 Feb 2003 19:53:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8075
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268127AbTBSAxT>; Tue, 18 Feb 2003 19:53:19 -0500
Subject: Re: PATCH: kill more ioregs, add OUTBSYNC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045601583.570.60.camel@zion.wanadoo.fr>
References: <E18lCIx-0006Az-00@the-village.bc.nu>
	 <1045601583.570.60.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045620299.25795.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 02:05:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 20:53, Benjamin Herrenschmidt wrote:
> On Tue, 2003-02-18 at 19:17, Alan Cox wrote:
> 
> > +	void (*OUTBSYNC)(u8 addr, unsigned long port);
> 
> This is the version without the drive parameter... This is
> on purpose ?

Im resynching where I am that works right on 2.4 before I feed Linus wildly
untested stuff. This may turn into enough fun as it is. Your PPC changes
are on the pile for the next round of fun, and the stuff that has been
tested like the spin up wait are in.

