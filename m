Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTEMKvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTEMKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 06:51:41 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:3713 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S263473AbTEMKvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 06:51:40 -0400
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.69-mm4
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513085525.GA7730@hh.idb.hist.no>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 13 May 2003 13:04:18 +0200
In-Reply-To: <20030513085525.GA7730@hh.idb.hist.no>
Message-ID: <87addr85vx.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Helge Hafting <helgehaf@aitel.hist.no> writes:

> On Tue, May 13, 2003 at 10:00:58AM +0200, Alexander Hoogerhuis wrote:
> > And this one :)
> > 
> >         ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> > kernel/built-in.o(.text+0x1005): In function `schedule':
> > : undefined reference to `active_load_balance'
> 
> I got this one too, as well as:
> drivers/built-in.o(.text+0x7d534): In function `fb_prepare_logo':
> : undefined reference to `find_logo'
> 

make clean; make on mine, still there...

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+wNEvCQ1pa+gRoggRAgi4AJ9gabgNlPOBxzTQmom8acDyaYA38QCgpg+w
fcZ3iMKojuGnvp0iTKGMDyE=
=0Gov
-----END PGP SIGNATURE-----
