Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCFOdz>; Thu, 6 Mar 2003 09:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTCFOdz>; Thu, 6 Mar 2003 09:33:55 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:44130 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261855AbTCFOdy>; Thu, 6 Mar 2003 09:33:54 -0500
Date: Thu, 6 Mar 2003 15:34:52 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cantab.net>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <Pine.SOL.3.96.1030306122732.1983B-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0303061521260.28143-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Anton Altaparmakov wrote:
> On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
> >
> > What would be really useful is to disassemble __ntfs_init_inode what I
> > asked 2 days ago (note, not the above 'make fs/ntfs/inode.S' because
> > it will not tell what machine code you have on disk), your .config and
> > exact CPU version (cat /proc/cpuinfo).
>
> Yes it will, unless you suspect the assembler [...]

I suspect everything :) It was also a polite way saying (on a completely
configured, etc kernel):
	% make fs/ntfs/inode.S
	make: *** No rule to make target `fs/ntfs/inode.S'.  Stop.

Anyway, considering how bogus the oops was and Randy already had two
oops'es before this NTFS one, I think the NTFS driver was a sufferer
of other trouble(s) than the originator. So unless one can reproduce
something close to this one (or Randy sends his first [two] oops), I
would just trash

	http://bugme.osdl.org/show_bug.cgi?id=432

    Szaka

