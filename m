Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313165AbSEVMy4>; Wed, 22 May 2002 08:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSEVMyz>; Wed, 22 May 2002 08:54:55 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:32011 "EHLO
	crawl.var.cx") by vger.kernel.org with ESMTP id <S313165AbSEVMyy>;
	Wed, 22 May 2002 08:54:54 -0400
Date: Wed, 22 May 2002 14:54:39 +0200
From: Frank v Waveren <fvw@var.cx>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <1022071962OHK.fvw@yendor.var.cx>
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com> <3CEB3F93.7030508@evision-ventures.com> <1022061793.28881.29.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:03:03PM +0200, Xavier Bestel wrote:
> Concerning point 2, you could always compress by chunks (say 1M) and
> take the compressed version only if it's smaller.
which would mean you'd have to add a bit to determine if it's the
compressed or the uncompressed chunk.. Which means you still have
the increased maximum size... There really is no way of getting around
the possible size increase.. (sorry to sound defeatist :) )

-- 
Frank v Waveren                                      Fingerprint: 0EDB 8787
fvw@[var.cx|stack.nl|dse.nl|chello.nl] ICQ#10074100     09B9 6EF5 6425 B855
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7179 3036 E136 B85D
