Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSJaDQn>; Wed, 30 Oct 2002 22:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSJaDQm>; Wed, 30 Oct 2002 22:16:42 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:46342 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265132AbSJaDQj>; Wed, 30 Oct 2002 22:16:39 -0500
Date: Thu, 31 Oct 2002 03:22:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org, tytso@mit.edu
Subject: Re: What's left over.
Message-ID: <20021031032253.A20572@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Peter Chubb <peter@chubb.wattle.id.au>, tridge@samba.org,
	tytso@mit.edu
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <20021031030143.401DA2C150@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021031030143.401DA2C150@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Oct 31, 2002 at 02:00:31PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:00:31PM +1100, Rusty Russell wrote:
> > I don't know why people still want ACL's. There were noises about them for 
> > samba, but I'v enot heard anything since. Are vendors using this?
> 
> SAMBA needs them, which is why serious Samba boxes use XFS.  Tridge,
> Ted?

XFS doesn't have ACLs either in plain 2.5.

> > Not for the feature freeze, there are some noises that imply that SuSE may 
> > push it in their kernels. 
> 
> They have, IIRC.  Interestingly, it was less invasive (existing source
> touched) than the LVM2/DM patch you merged.

But that only because dm added stuff to the generic code where we
told it. It's a lot more code than dm and it adds new discovery
code at the same time we start moving stuff _out_ of the kernel
to initramfs.

If you can SuSE has merged it any IBM patch posted here should get
in, coming from big blue seems to be a basic merge criteria in
Nuernberg :)

