Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbQLHLqo>; Fri, 8 Dec 2000 06:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131501AbQLHLqf>; Fri, 8 Dec 2000 06:46:35 -0500
Received: from www.inreko.ee ([195.222.18.2]:64224 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S130460AbQLHLqU>;
	Fri, 8 Dec 2000 06:46:20 -0500
Date: Fri, 8 Dec 2000 13:25:53 +0200
From: Marko Kreen <marko@l-t.ee>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
Message-ID: <20001208132553.C5744@l-t.ee>
In-Reply-To: <UTC200012080235.DAA157231.aeb@aak.cwi.nl> <Pine.GSO.4.21.0012072156420.22281-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0012072156420.22281-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Dec 07, 2000 at 09:59:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 09:59:18PM -0500, Alexander Viro wrote:
> On Fri, 8 Dec 2000 Andries.Brouwer@cwi.nl wrote:
> > > BTW, could we finally lose mpx(2)?
> > 
> > Maybe we lost it - I find sys_mpx only in a comment in arch/arm/kernel/calls.S
> 
> Sure, but man2/mpx.2 is alive and well...

manpages-dev 1.31-1 of debian:

$ ll /usr/share/man/man2/mpx.2.gz
... /usr/share/man/man2/mpx.2.gz -> unimplemented.2.gz

$ man 2 mpx

NAME
       afs_syscall,  break,  ftime,  gtty, lock, mpx, phys, prof,
       profil, stty, ulimit - unimplemented system calls

-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
