Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSDPOtW>; Tue, 16 Apr 2002 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313699AbSDPOtV>; Tue, 16 Apr 2002 10:49:21 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31044 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313698AbSDPOtU>; Tue, 16 Apr 2002 10:49:20 -0400
Date: Tue, 16 Apr 2002 16:49:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Tom Holroyd <tomh@po.crl.go.jp>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
Message-ID: <20020416164919.D29747@dualathlon.random>
In-Reply-To: <Pine.LNX.4.21.0204041627580.10117-100000@freak.distro.conectiva> <Pine.LNX.4.44.0204051300130.9007-100000@holly.crl.go.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 01:13:30PM +0900, Tom Holroyd wrote:
> On Thu, 4 Apr 2002, Marcelo Tosatti wrote:
> 
> > Could you please try to reproduce with 2.4.19-pre4 ?
> 
> OK, I could, so I searched back and -pre1 was OK.  This behavior
> showed up in -pre2.  It seems to be related to the mm changes.
> Unfortunately I don't know how to back those out safely to check that.
> 
> To repeat, I set up a window that has to be redrawn (no backing
> store), then use ee (electric eyes) to scroll through 50 or so JPGs
> then go back to redraw the aforementioned window.  In -pre2 I get 5
> sec freezes and no disk IO during the interval, so it seems like a
> memory management thing.
> 
> Any tests I could do?  A -pre2 patch without the mm changes?

there are no mm diffs between pre1 and pre2. The first mm changes are in
pre5.

Andrea
