Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTFHV2N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 17:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263915AbTFHV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 17:28:13 -0400
Received: from CPE-65-29-18-81.mn.rr.com ([65.29.18.81]:20149 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S263897AbTFHV2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 17:28:06 -0400
Subject: Re: What are .s files in arch/i386/boot
From: Shawn <core@enodev.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200306082204.16079.josh@stack.nl>
References: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org>
	 <6un0gty981.fsf@zork.zork.net> <bbtlc6$qtd$1@cesium.transmeta.com>
	 <200306082204.16079.josh@stack.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1055108498.785.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 08 Jun 2003 16:41:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that it's a bad thing or anything, but holy crap! I didn't think
there was this level of hand-holding on this list.

It's nice to see folks willing to tutor, but really, don't get burned
out. This list is probably better suited to handling deeper questions.

On Sun, 2003-06-08 at 15:04, Jos Hulzink wrote:
> On Saturday 07 Jun 2003 23:27, H. Peter Anvin wrote:
> > Followup to:  <6un0gty981.fsf@zork.zork.net>
> > By author:    Sean Neakums <sneakums@zork.net>
> > In newsgroup: linux.dev.kernel
> >
> > > James Stevenson <james@stev.org> writes:
> > > >> > > What are .s files in arch/i386/boot, are they c sources of some
> > > >> > > sort? Where can I find the specifications documents they were made
> > > >> > > from?
> > > >> >
> > > >> > There are not c files.
> > > >> > They are assembler files
> > > >> >
> > > >> Where can I find the .c files they were made from,
> > > >> and the spec sheets the .c files were made from?
> > > >
> > > > You would have to find the original author of the person
> > > > who tweaks the assembler in the .s file chances are the .c
> > > > file is long gone though.
> > >
> > > If there were ever C files to begin with.  It's not unheard-of for
> > > people to write assembler code from scratch.
> >
> > The ones in the Linux kernel were all written from scratch.
> 
> And for a very good reason. A few things really need asm, for example getting 
> a CPU in protected mode, setting up the MMU and stuff. Once they are set up, 
> you can use C, though sometimes you must be really sure what your compiler 
> will make from the C.
> 
> So, why assembly ? Cause it is needed. Why in arch/i386/boot ? for if it is 
> well done there, it isn't needed at many other locations. A few things will 
> still require asm though, therefore you'll find more .s files in arch/i386. 
> 
> Jos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
