Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbRETTTS>; Sun, 20 May 2001 15:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbRETTTI>; Sun, 20 May 2001 15:19:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28940 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262154AbRETTTD>;
	Sun, 20 May 2001 15:19:03 -0400
Date: Sun, 20 May 2001 20:18:16 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010520201816.T23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com> <Pine.GSO.4.21.0105201509060.8940-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0105201509060.8940-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, May 20, 2001 at 03:11:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 03:11:53PM -0400, Alexander Viro wrote:
> Pheeew... Could you spell "about megabyte of stuff in ioctl.c"?

No.

$ ls -l arch/*/kernel/ioctl32*.c
-rw-r--r--    1 willy    willy       22479 Jan 24 16:59 arch/mips64/kernel/ioctl32.c
-rw-r--r--    1 willy    willy      109475 May 18 16:39 arch/parisc/kernel/ioctl32.c
-rw-r--r--    1 willy    willy      117605 Feb  1 20:35 arch/sparc64/kernel/ioctl32.c

only about 100k.

-- 
Revolutions do not require corporate support.
