Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282466AbRKZUTV>; Mon, 26 Nov 2001 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282467AbRKZUTP>; Mon, 26 Nov 2001 15:19:15 -0500
Received: from borg.org ([208.218.135.231]:47881 "HELO borg.org")
	by vger.kernel.org with SMTP id <S282466AbRKZUS7>;
	Mon, 26 Nov 2001 15:18:59 -0500
Date: Mon, 26 Nov 2001 15:18:56 -0500
From: Kent Borg <kentborg@borg.org>
To: war <war@starband.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
Message-ID: <20011126151856.F20261@borg.org>
In-Reply-To: <Pine.LNX.4.10.10111221006010.29736-100000@coffee.psychology.mcmaster.ca> <3BFD2915.D640C3CB@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFD2915.D640C3CB@starband.net>; from war@starband.net on Thu, Nov 22, 2001 at 11:34:29AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 11:34:29AM -0500, war wrote:
> Unworkable?
> How is it unworkable for my situation?
> I have 1GB of memory, even when I launch every application I can, I still have
> 350MB left over!

Yes, even X can't easily use up 1 GB by just launching a bunch of
applications.  

Times have changed.  It used to be that RAM was very dear and even
slow and small disks of olden days were worth using to extend the RAM
via a virtual memory scheme.  In many cases today it is quite workable
to throw more RAM at a computer than one can easily use without
"cheating" (say, letting Netscape leak for a few weeks).  But not all
cases.  Some problems are bigger than yours (big databases love RAM,
some video post production loves RAM), and some machines are smaller
than yours (in physical size, power usage, cost).

If you use your computer in such a way that you keep hundreds of
megabytes of RAM free and having swap slows you down, that is a bug
about which people on this list will want hear details.

If you start to use your computer more heavily so that you start to
use swap, and swap slows you down, then there will be interest in how
are doing that.  It might be a bug, it might be an unfortunate
accident of not being able to have one VM for all occasions.

If you start to heavily use swap and it slows you down (when compared
to having no swap), that is also a bug.  Tell the world the details.


-kb, the Kent whose basement server runs with only 64 MB RAM, and yet
though it is always using some swap, the swap usage always seems to be
a smaller number than the amount of RAM used for cache.
