Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131599AbQJ2K21>; Sun, 29 Oct 2000 05:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131610AbQJ2K2R>; Sun, 29 Oct 2000 05:28:17 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:6273 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S131599AbQJ2K2C>; Sun, 29 Oct 2000 05:28:02 -0500
Date: Sun, 29 Oct 2000 11:27:58 +0100
From: David Weinehall <tao@acc.umu.se>
To: Stephen Crowley <stephenc@digitalpassage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs.c:567
Message-ID: <20001029112758.B768@khan.acc.umu.se>
In-Reply-To: <20001028184342.A1525@intolerance.digitalpassage.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001028184342.A1525@intolerance.digitalpassage.com>; from stephenc@digitalpassage.com on Sat, Oct 28, 2000 at 06:43:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 06:43:42PM -0500, Stephen Crowley wrote:
> kernel 2.4.0-test10-pre6, but this has been here as long as I can
> remember.
> 
> starting wine triggers the bug, C: points to /win2k which is an NTFS
> filesystem.

[snip]

Yep, there's a solution for this. Get yourself the complete
specifications for the Win2K NTFS, and implement it. The kernel NTFS
simply doesn't support the Win2K NTFS, and rather than risking anything,
it just OOPS:es. Not that I have any Win2K systems, but if I had, I'd
damn sure rather see the kernel OOPS than those filesystems trashed.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
