Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318354AbSGRUTh>; Thu, 18 Jul 2002 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSGRUTh>; Thu, 18 Jul 2002 16:19:37 -0400
Received: from ns.suse.de ([213.95.15.193]:5129 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318354AbSGRUTf>;
	Thu, 18 Jul 2002 16:19:35 -0400
Date: Thu, 18 Jul 2002 22:22:29 +0200
From: Dave Jones <davej@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020718222229.B21997@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bill Davidsen <davidsen@tmr.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D361091.13618.16DC46FB@localhost> <Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020718123016.8220B-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:46:43PM -0400, Bill Davidsen wrote:

 > > o New kernel build system (kbuild 2.5)            (Keith Owens)
 > 	I fear Keith might go SPC if this had to wait for 2.7

Bit by bit, either parts of Keith's work, or orthogonal ideas
are making it in. Whether the big chunks make it by halloween remains
to be seen.

 > > o Add XFS (A journaling filesystem from SGI)      (XFS team)
 > > o Asynchronous IO (aio) support                   (Ben LaHaise)
 > > o LVM (Logical Volume Manager) v2.0               (LVM team)
 > 	I thought these were all progressing nicely

All are aiming for halloween, but none (afaik) have put forward
anything that can be merged yet. The XFS & LVM folks are still
cleaning bits and getting things presentable, whilst Ben is still
at work with aio I guess (judging by his relative silence since
the summit 8-)

 > > o Page table sharing                              (Daniel Phillips)
 > > o ext2/ext3 online resize support                 (Andreas Dilger)
 > 	Definitely want to stabilize these

"would be nice".

 > > o UDF Write support for CD-R/RW (packet writing)  (Jens Axboe, Peter Osterlund)
 > 	Hopefully this is close as well

This has been around for an age, but I haven't seen anything for 2.5
yet. Then again, I dropped off the packet-writing mailing list a long
time ago, so I'm not sure how up to date those folks are.

 > > o Full compliance with IPv6                       (Alexey Kuznetzov, Jun Murai, Yoshifuji Hideaki, USAGI team)
 > 	could ease in 2.6.x if not?

Davem's call I guess. ISTR the USAGI work was a rather large patch which
if in Davem's shoes, I'd be rather dubious about taking 'all-in-one'.

 > > o Add support for NFS v4                          (NFS v4 team)
 > 	This really shouldn't wait for 2.8!

Last I saw of this patch it was still against something like 2.4.1,
so they have a lot of catch up to do. This fact asides, if it doesn't
touch common code, there's no reason it can't go in post-feature freeze
in the same way as a driver/additional fs. Depends how much it touches.
That said, are there really that many NFSv4 hosts out there that make
this a *must have* feature ? Are any other *nix vendors shipping NFSv4 yet?

 > > o Remove the 2TB block device limit               (Peter Chubb)
 > 	This would help db folks now, and who knows how big
 > 	a single drive will be before 2.7?

Agreed, a pretty important feature.

 > > o Overhaul PCMCIA support                         (David Woodhouse, David Hinds)
 > 	Sure would be nice if it worked on desktops as well as laptops

"works for me". Admittedly I've not played with pcmcia much, but it
seems at least if you choose the right hardware it works fine.

 > > o Add thrashing control                           (Rik van Riel)
 > I sure would like to see documentation improvements on this list! For 2.6
 > it would be beautiful is no features went into /proc/sys unless they went
 > into the Documentation directory as well.	

ObRelated: There was some shouting about a sysctlfs at some point
which could clean up a lot of the crap in /proc/sys at the expense of
an extra mount. Al ?

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
