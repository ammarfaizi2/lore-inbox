Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132279AbQKZQFF>; Sun, 26 Nov 2000 11:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132276AbQKZQEz>; Sun, 26 Nov 2000 11:04:55 -0500
Received: from [213.182.136.121] ([213.182.136.121]:46863 "EHLO
        tigram.bogus.local") by vger.kernel.org with ESMTP
        id <S132161AbQKZQEq>; Sun, 26 Nov 2000 11:04:46 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <Pine.LNX.4.21.0011251805340.8818-100000@duckman.distro.conectiva>
From: Olaf Dietsche <olaf.dietsche@gmx.net>
Date: 26 Nov 2000 16:33:25 +0100
Message-ID: <87ofz2lpdm.fsf@tigram.bogus.local>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sat, 25 Nov 2000, Andries Brouwer wrote:
> > On Sat, Nov 25, 2000 at 03:26:15PM -0200, Rik van Riel wrote:
> > 
> > > The gcc-2.95.2-6cl from Conectiva 6.0 is buggy too.
> > 
> > Yes. Probably you have seen it by now, but the difference between
> > good and bad versions of gcc-2.95.2 did not lie in the applied patches,
> > but was the difference between compilation for 686 or 386.
> > It is not your (SuSE's, Debian's) fault. A fix already exists.
> 
> Indeed, this should be fixed soon.
> 
> I'm sure a simple 'apt-get upgrade' will install a new
> gcc RPM on my workstation soon ;)

A simple `gcc -march=i686' or `gcc -mpentiumpro' does fix it as
well. So, if you configure your kernel with `CONFIG_M686=y' the problem
should be gone.

Regards, Olaf.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
