Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265176AbSJPQd2>; Wed, 16 Oct 2002 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265178AbSJPQd2>; Wed, 16 Oct 2002 12:33:28 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:44000 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S265176AbSJPQd0>; Wed, 16 Oct 2002 12:33:26 -0400
Date: Wed, 16 Oct 2002 18:35:56 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Christoph Hellwig <hch@sgi.com>
cc: Miles Bader <miles@gnu.org>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org
Subject: Re: mapping 36 bit physical addresses into 32 bit virtual
In-Reply-To: <20021016192143.B22932@sgi.com>
Message-ID: <Pine.GSO.3.96.1021016181542.19873J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Christoph Hellwig wrote:

> > You're wrong -- the R4000 was absolutely 64-bit, and was released in
> > 1991.  The 64-bit sparc was circa '93, and alpha I dunno, but I think
> > '91-'92.
> 
> The 64bit mode of the original r4k was so buggy that you couldn't use
> it in practice..

 Any specific references?  Recently I've been able to get seemingly quite
stable builds of MIPS64/Linux running on an R4000SC rev. 3.0 (I believe
the initial commercial release was 2.2 and that only differs by two
additional errata documented that are not related to 64-bit operation
anyway) and an R4400SC rev. 1.0 (the initial one).  It wasn't entirely
straightforward to get proper workarounds implemented and the errata used
to bite badly without them, but now the kernel seems to run quite well --
I used to get uptimes of a week with only an administrative shutdown
breaking them.

 But that's the kernel only -- we still lack a 64-bit userland which may
reveal additional gotchas.  Do you know of anything I should be aware of
beside the errata as officially documented by MIPS?  What is documented is
somewhat painful but not a showstopper -- I hope nothing else exists.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

