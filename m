Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261167AbRELD7r>; Fri, 11 May 2001 23:59:47 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261151AbRELD7J>; Fri, 11 May 2001 23:59:09 -0400
Received: from zeus.kernel.org ([209.10.41.242]:49800 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261170AbRELD6M>;
	Fri, 11 May 2001 23:58:12 -0400
Date: Sat, 12 May 2001 03:24:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mauelshagen@sistina.com,
        linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0 release decision
Message-ID: <20010512032453.A8259@athlon.random>
In-Reply-To: <20010511162745.B18341@sistina.com> <E14yDyI-0000yE-00@the-village.bc.nu> <20010511171124.M30355@athlon.random> <15100.18375.367656.3591@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15100.18375.367656.3591@pizda.ninka.net>; from davem@redhat.com on Fri, May 11, 2001 at 01:12:55PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 01:12:55PM -0700, David S. Miller wrote:
> They can be converted, [..]

of course, and part of that code will be still necessary also with the
>=beta4 lvm interface to still convert the pointers of the userspace
data structures but my point was we probably want to avoid that complexity
where it's not necessary (feasible was too strong adj sorry).

Related side note: for the x86-64 kernel we won't support the emulation
of the lvm ioctl from the 32bit executables to avoid the pointer
conversion an mainteinance pain enterely, at least in the early stage
the x86-64 lvmtools will have to be compiled elf64.

Andrea
