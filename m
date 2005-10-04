Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVJDGds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVJDGds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 02:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVJDGds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 02:33:48 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:61188
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S932371AbVJDGdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 02:33:47 -0400
Date: Mon, 3 Oct 2005 23:30:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ryan Anderson <ryan@autoweb.net>
cc: Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <1128377075.23932.5.camel@ryan2.internal.autoweb.net>
Message-ID: <Pine.LNX.4.10.10510032319070.410-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Oct 2005, Ryan Anderson wrote:

> On Mon, 2005-10-03 at 23:26 +0200, Tomasz K³oczko wrote:
> > If (cytation from Linus) "a 'spec' is close to useless" ..
> > Q: why the hell in kernel tree is included Documentation/ subdirectory ?
> > Is it raly content of this directory is "close to useless" or maybe it not
> > contains some specyfications ? :>
> 
> Let me rephrase what Linus said, to help remove the misreading that
> seems so common today.  I think a fair rewording would be, "A spec is a
> guideline.  When it fails to match reality, continuing to follow it is a
> tremendous mistake."
> 
> Additionally, I think the overall LKML feeling on hardware specs and the
> corresponding software abstractions to deal with it can be summarized
> something like this:
> 
> When the spec provides a software design that doesn't fit into the
> overall structure of the Linux kernel, the spec should be treated as a
> suggestion for a software design.  The *interface* that the spec
> documents should be followed, where it moves out of the overall
> structure, but internally, a design that fits into the Linux kernel is
> more important than following a spec that doesn't fit.

Please lets design against the transport or FSM of the storage transport
and never see data again.  NCITS specs generally (used loosely) define the
boundary conditions for stable operations.  One of jewels of linux in the
past which (hopefully was fixed, was 1.2.X-2.5.X thingy) was buffer_head
walking and release to satisfy transfer of data-blocks of a spindle
against the data-blocks of the kernel.  Spindle must win or one can not
insure data integrity, thus the advent of BIO's from BH.

Linux changed to conform to data integrity issues.

Somedays, Linux's API's or designs are OTS (Over The Shoulder).

You get crap all over your back, if you reach OTS to finish your washroom
business.  It is functional but ends up stinky and messy.

This thread is getting longer and I just added to piles ...

Sigh

Andre

