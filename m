Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274851AbRJFCDH>; Fri, 5 Oct 2001 22:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274866AbRJFCCs>; Fri, 5 Oct 2001 22:02:48 -0400
Received: from CPE-61-9-150-107.vic.bigpond.net.au ([61.9.150.107]:34039 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274851AbRJFCCk>; Fri, 5 Oct 2001 22:02:40 -0400
Message-ID: <3BBE621C.203E11EC@eyal.emu.id.au>
Date: Sat, 06 Oct 2001 11:45:00 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
In-Reply-To: <200110052048.NAA19993@baldur.yggdrasil.com> <20011005231732.B19985@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Oct 05, 2001 at 01:48:42PM -0700, Adam J. Richter wrote:
> >       Attempting to compile linux-2.4.11-pre4/drivers/mtd/bootldr.c
> > fails with a bunch of compiler errors, including a complaint that
> > "struct tag" is not defined anywhere.  Presumably this is the result
> > of an incompletely applied patch.
> 
> Firstly, its ARM only.  Secondly, Compaq decided that a partition table in

Not so. I got this error on i386. I used 'make oldconfig' and was
offered
some new options in the JFFS2 area (which I always accept, just to check
the build).

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
