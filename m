Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267885AbTCFTau>; Thu, 6 Mar 2003 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268198AbTCFTau>; Thu, 6 Mar 2003 14:30:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267885AbTCFTat>;
	Thu, 6 Mar 2003 14:30:49 -0500
Date: Thu, 6 Mar 2003 11:39:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
Message-Id: <20030306113942.6f9bbbf5.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303061521260.28143-100000@divine.city.tvnet.hu>
References: <Pine.SOL.3.96.1030306122732.1983B-100000@draco.cus.cam.ac.uk>
	<Pine.LNX.4.30.0303061521260.28143-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003 15:34:52 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| 
| On Thu, 6 Mar 2003, Anton Altaparmakov wrote:
| > On Thu, 6 Mar 2003, Szakacsits Szabolcs wrote:
| > >
| > > What would be really useful is to disassemble __ntfs_init_inode what I
| > > asked 2 days ago (note, not the above 'make fs/ntfs/inode.S' because
| > > it will not tell what machine code you have on disk), your .config and
| > > exact CPU version (cat /proc/cpuinfo).
| >
| > Yes it will, unless you suspect the assembler [...]
| 
| I suspect everything :) It was also a polite way saying (on a completely
| configured, etc kernel):
| 	% make fs/ntfs/inode.S
| 	make: *** No rule to make target `fs/ntfs/inode.S'.  Stop.
| 
| Anyway, considering how bogus the oops was and Randy already had two
| oops'es before this NTFS one, I think the NTFS driver was a sufferer
| of other trouble(s) than the originator. So unless one can reproduce
| something close to this one (or Randy sends his first [two] oops), I
| would just trash
| 
| 	http://bugme.osdl.org/show_bug.cgi?id=432

I must have missed something here.  What other 2 oopses are you referring to?
I understand that other oopses could make a third one bogus, but I didn't
see 2 others.  Did I miss them?  How did you get that information?
I'll look in the kernel log tonight (at home) to see if I missed them.

As for closing bug reports because they are not reproducible...
sure, people do it, and whoever wants to can close bug reports for that reason,
but you won't catch me doing that.  It's a poor reason to close a bug report
IMO.

--
~Randy
