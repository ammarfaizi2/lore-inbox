Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbUKDWjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbUKDWjA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbUKDWiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:38:13 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:38870 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262467AbUKDWcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:32:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16778.44490.244730.653423@wombat.chubb.wattle.id.au>
Date: Fri, 5 Nov 2004 09:31:38 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
In-Reply-To: <20041104100749.GA23996@merlin.emma.line.org>
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031124.19179.gene.heskett@verizon.net>
	<20041103201322.GA10816@hh.idb.hist.no>
	<200411031540.03598.gene.heskett@verizon.net>
	<20041104100749.GA23996@merlin.emma.line.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthias" == Matthias Andree <matthias.andree@gmx.de> writes:

Matthias> On Wed, 03 Nov 2004, Gene Heskett wrote:
>> >Yes it does - the problem is that not all resources are managed
>> >by processes.  Some allocations are managed by drivers, so a
>> driver >bug can get the device into a unuseable state _and_ tie up
>> the >process(es) that were using the driver at the moment.
>> 
>> This from my viewpoint, is wrong.  The kernel, and only the kernel
>> should be ultimately responsible for handing out resources, and
>> reclaiming at its convienience.

Matthias> Linux's driver model is the way it is. If you want the
Matthias> kernel to clean up after a driver has puked, you need
Matthias> something like a microkernel I believe, where only a minimal
Matthias> core kernel is a real kernel and where all the drivers are
Matthias> actually in user-space, but that's no longer Linux then.

Matthias> I'm not reflecting the down- and upsides to of this as I
Matthias> have no experience with microkernels (and have never used
Matthias> OS9 or GNU Hurd either). I know there have been attempts to
Matthias> port Linux to a Microkernel but I don't know what's come out
Matthias> of it.

There are actually several ports of Linux onto microkernels, but the
only one I know anything about is the Wombat project here at UNSW.

Linux running on the L4 microkernel runs at around the same speed as
on the bare metal.  The home page is at
http://www.disy.cse.unsw.edu.au/Software/Wombat/ but there's not much
there yet.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
