Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136793AbREISC7>; Wed, 9 May 2001 14:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136797AbREISCj>; Wed, 9 May 2001 14:02:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49675 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136793AbREISCg>; Wed, 9 May 2001 14:02:36 -0400
Subject: Re: Nasty Requirements for non-GPL Linux Kernel Modules?
To: scott@CS.Princeton.EDU
Date: Wed, 9 May 2001 19:06:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105091750.f49HoEg20765@chinstrap.CS.Princeton.EDU> from "Scott C. Karlin" at May 09, 2001 01:50:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xYMC-0002vn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As part of our operating system / networking research, we have
> written a loadable kernel module for Linux.  We would like to
> distribute the source but we're not sure if our development
> office will allow us to release it under the GPL (at least
> initially).  Before meeting with the lawyers, I'm trying to
> learn what I can about the issue.

If you want to do binary only then it depends solely how your lawyers intend
to interpret the concept of 'linking'. Linus comments on the matter have no
impact since the kernel isnt all his copyright and he has linked in code by
bodies who are most definitely opposed to binary modules.

The same applies for source code under 'additional restrictions' as the GPL
calls things disallowing stuff it allows.

If you are releasing modules with source under terms that are at least as free
as the GPL (eg BSD without advertising clause) then nobody has any cares. We
probably wouldnt merge it with the mainstream kernel due to the lack of
patent trap protection in the BSD license but I suspect you dont want that
anyway.

Alan

