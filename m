Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbQKISpi>; Thu, 9 Nov 2000 13:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129209AbQKISp2>; Thu, 9 Nov 2000 13:45:28 -0500
Received: from u-97.karlsruhe.ipdial.viaginterkom.de ([62.180.21.97]:20996
	"EHLO u-97.karlsruhe.ipdial.viaginterkom.de") by vger.kernel.org
	with ESMTP id <S129112AbQKISpU>; Thu, 9 Nov 2000 13:45:20 -0500
Date: Thu, 9 Nov 2000 13:22:51 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design
Message-ID: <20001109132250.A1106@bacchus.dhis.org>
In-Reply-To: <200011071330.eA7DUdw26230@pincoya.inf.utfsm.cl> <E13t9EH-0007Ra-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E13t9EH-0007Ra-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 07, 2000 at 01:55:59PM +0000
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 01:55:59PM +0000, Alan Cox wrote:

> > Note! This _has_ to be in the / filesystem so it works before mounting the
> > rest of the stuff (if ever). This would rule out /var, and leave just
> > /lib/modules/<version>. Makes me quite unhappy...
> 
> The /lib filesystem is likely not writable so /var is the right default. 

In theory yes.  In practice /var is often a mounted filesyste so for
modules loaded before /var is mounted this solution gets somewhat ugly.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
