Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283719AbRLXXjF>; Mon, 24 Dec 2001 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283770AbRLXXi4>; Mon, 24 Dec 2001 18:38:56 -0500
Received: from pop.gmx.de ([213.165.64.20]:65069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283719AbRLXXir>;
	Mon, 24 Dec 2001 18:38:47 -0500
Message-ID: <3C27BA0D.58F0A02C@gmx.de>
Date: Tue, 25 Dec 2001 00:28:13 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Doug Ledford <dledford@redhat.com>, Keith Owens <kaos@ocs.com.au>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <3C2770FE.80403@redhat.com> <E16IaPj-0004u4-00@the-village.bc.nu> <20011224193124.F2110@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Mon, Dec 24, 2001 at 07:05:31PM +0000, Alan Cox wrote:
> > > it.  However, I think it needs to be allocated *regardless* of whether Linus
> > > takes the patch into his kernel.  Even if the patch is simply used outside
> > > Linus's kernel, it still needs the allocation to truly be safe.
> >
> > Negative numbers are safe until Linus has 2^31 syscalls, at which point
> > quite frankly we would have a few other problems including the fact that
> > the syscall table won't fit in kernel mapped memory.
> 
> Please leave the allocation of the exact number space to the port
> maintainers discression.

Why not assign 1 syscall that gets the name of an experimental syscall
as its first argument and does the demultiplexing?

Ciao, ET.
