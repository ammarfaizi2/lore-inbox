Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289121AbSAGFST>; Mon, 7 Jan 2002 00:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289123AbSAGFR7>; Mon, 7 Jan 2002 00:17:59 -0500
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:62479 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S289121AbSAGFRz>; Mon, 7 Jan 2002 00:17:55 -0500
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Mon, 7 Jan 2002 00:17:54 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
Message-ID: <20020107001754.D7272@ccmr.cornell.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020106133939.A6408@ccmr.cornell.edu> <200201061856.g06IuXma007731@sm13.texas.rr.com> <20020106144525.B6408@ccmr.cornell.edu> <200201062011.g06KBpu3007487@sm14.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200201062011.g06KBpu3007487@sm14.texas.rr.com>; from mjustice@austin.rr.com on Sun, Jan 06, 2002 at 02:15:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002, Marvin Justice wrote:
> On Sunday 06 January 2002 01:45 pm, Daniel Freedman wrote:
> > Hi Marvin,
> >
> > Thanks for the quick reply.
> >
> > On Sun, Jan 06, 2002, Marvin Justice wrote:
> > > Is this what your looking for? Just below the definition of PAGE_OFFSET
> > > in page.h:
> > >
> > > /*
> > >  * This much address space is reserved for vmalloc() and iomap()
> > >  * as well as fixmap mappings.
> > >  */
> > > #define __VMALLOC_RESERVE	(128 << 20)
> >
> > However, while it does seem to be exactly the definition for 128MB
> > vmalloc offset that I was looking for, I don't seem to have this
> > definition in my source tree (2.4.16):
> >
> >   freedman@planck:/usr/src/linux$ grep -r __VMALLOC_RESERVE *
> >   freedman@planck:/usr/src/linux$
> 
> Hmmm. Looks like it was moved sometime between 2.4.16 and 2.4.18pre1. In my 
> 2.4.16 tree it's located in arch/i386/kernel/setup.c and without the leading 
> underscores.
> 
> -M

<sheepishly buries head in sand>  Oops...  Sorry about missing that.

Thanks for the help and take care,

Daniel

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
