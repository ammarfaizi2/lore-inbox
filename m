Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbRETTYi>; Sun, 20 May 2001 15:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262162AbRETTY2>; Sun, 20 May 2001 15:24:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50904 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262157AbRETTYR>;
	Sun, 20 May 2001 15:24:17 -0400
Date: Sun, 20 May 2001 15:24:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <matthew@wil.cx>
cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <20010520201816.T23718@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0105201523370.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Matthew Wilcox wrote:

> On Sun, May 20, 2001 at 03:11:53PM -0400, Alexander Viro wrote:
> > Pheeew... Could you spell "about megabyte of stuff in ioctl.c"?
> 
> No.
> 
> $ ls -l arch/*/kernel/ioctl32*.c
> -rw-r--r--    1 willy    willy       22479 Jan 24 16:59 arch/mips64/kernel/ioctl32.c
> -rw-r--r--    1 willy    willy      109475 May 18 16:39 arch/parisc/kernel/ioctl32.c
> -rw-r--r--    1 willy    willy      117605 Feb  1 20:35 arch/sparc64/kernel/ioctl32.c
> 
> only about 100k.

You are missing all x86-only drivers.

