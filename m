Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVEPOsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVEPOsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 10:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVEPOsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 10:48:41 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34208 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261668AbVEPOsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 10:48:36 -0400
Date: Mon, 16 May 2005 16:48:31 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050516144831.GA949@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116252157.6274.41.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Arjan van de Ven wrote:

> > See the problem: "I assume", "IIRC selected...". There is no
> > list of corroborated facts which systems work and which don't. I have
> > made several attempts in compiling one, posting public calls for data
> > here, no response.
> 
> well what stops you from building that list yourself by doing the actual
> work yourself?

Two things.

#1 it's the subsystem maintainer's responsibility to arrange for such
information. I searched Documentation/* to no avail, see below.

#2 That I would need to get acquainted with and understand several dozen
subsystems, drivers and so on to be able to make a substantiated
statement.

Subsystem maintainers will usually know the shape their code is in and
just need to state "not yet", "not planned", "not needed, different
layer", "work in progress" or "working since kernel version 2.6.42".

Takes a minute per maintainer, rather than wasting countless hours on
working through foreign code only to forget all this after I know what I
wanted to know. Sounds like an unreasonable expectation? Not to me. I
had hoped, several times, that asking here would give the first dozen of
answers as a starting point.

It's not as though I could go forth and just take two weeks off a shelf
and read all common block devices code...

I still have insufficient information even for ext3 on traditional
parallel ATA interfaces, so how do I start a list without information?

$ cd linux-2.6/Documentation/
$ find -iname '*barr*'
./arm/Sharp-LH/IOBarrier
$ head -4 ../Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 11
EXTRAVERSION = .9
$

Documentation/block/biodoc.txt has some information about how it could
look like two years from now. filesystems/ext3 mentions it requires a
barrier=1 mount option. No information what block interfaces support it.

AIC7XXX was once reported to have it, experimentally, I don't know what
has become of the code, and I don't have AIC7XXX here, too expensive.

-- 
Matthias Andree
