Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267978AbTGRHis (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbTGRHis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:38:48 -0400
Received: from mail1.kontent.de ([81.88.34.36]:22194 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267978AbTGRHir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:38:47 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>
Subject: Re: devfsd
Date: Fri, 18 Jul 2003 09:52:33 +0200
User-Agent: KMail/1.5.1
Cc: Ro0tSiEgE LKML <lkml@ro0tsiege.org>, KML <linux-kernel@vger.kernel.org>
References: <20030715214610.GA21238@core.citynetwireless.net> <1058507844.13515.1579.camel@workshop.saharacpt.lan> <20030718084417.B14336@infradead.org>
In-Reply-To: <20030718084417.B14336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307180952.33868.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 18. Juli 2003 09:44 schrieb Christoph Hellwig:
> On Fri, Jul 18, 2003 at 07:57:24AM +0200, Martin Schlemmer wrote:
> > Apart from obvious/known inefficiencies, it works fine over here :P
> > 
> > Any way, if you are serious, what make you consider it broken (no,
> > not talking about personal preferences/phobias 8)
> 
> There's unsolvable design issues in the way devfsd communication works
> (with the last two patches the holes are closed as much as possible)

Could you elaborate?

> and it's fundamentally flawed by putting device name policy into
> the kernel.   And then there's of course certain implementation quality
> issues...
> 
> We have udev now which solves what devfs tried to solve without that
> issues so people should switch to that ASAP.  That doesn't mean we
> can simply rip it out because people started to rely on the non-standard
> device names, but it's use is pretty much discouraged in 2.6.

How does udev avoid these complications?
If udev doesn't have those issues, why can't they be fixed for devfsd?

	Regards
		Oliver

