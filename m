Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130361AbQJ2RZs>; Sun, 29 Oct 2000 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbQJ2RZ2>; Sun, 29 Oct 2000 12:25:28 -0500
Received: from mail.archerassoc.com ([12.14.185.5]:40720 "EHLO
	digitalpassage.com") by vger.kernel.org with ESMTP
	id <S130361AbQJ2RZV>; Sun, 29 Oct 2000 12:25:21 -0500
Date: Sun, 29 Oct 2000 11:25:14 -0600
To: David Weinehall <tao@acc.umu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs.c:567
Message-ID: <20001029112514.A20492@intolerance.digitalpassage.com>
In-Reply-To: <20001028184342.A1525@intolerance.digitalpassage.com> <20001029112758.B768@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029112758.B768@khan.acc.umu.se>; from tao@acc.umu.se on Sun, Oct 29, 2000 at 11:27:58AM +0100
From: Stephen Crowley <stephenc@digitalpassage.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 11:27:58AM +0100, David Weinehall wrote:
> On Sat, Oct 28, 2000 at 06:43:42PM -0500, Stephen Crowley wrote:
> > kernel 2.4.0-test10-pre6, but this has been here as long as I can
> > remember.
> > 
> > starting wine triggers the bug, C: points to /win2k which is an NTFS
> > filesystem.
>
> Yep, there's a solution for this. Get yourself the complete
> specifications for the Win2K NTFS, and implement it. The kernel NTFS
> simply doesn't support the Win2K NTFS, and rather than risking anything,
> it just OOPS:es. Not that I have any Win2K systems, but if I had, I'd
> damn sure rather see the kernel OOPS than those filesystems trashed.

I see.. but the FS is mounted read-only, so even if it didn't oops why would
there be a risk of it getting trashed? I really wouldn't mind if it did got
trashed.. thanks for the pointer though.

-- 
Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
