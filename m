Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSCOTZh>; Fri, 15 Mar 2002 14:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293190AbSCOTXN>; Fri, 15 Mar 2002 14:23:13 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:47622 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S293169AbSCOTVm>; Fri, 15 Mar 2002 14:21:42 -0500
Date: Sat, 16 Mar 2002 04:49:17 +1100
From: john slee <indigoid@higherplane.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Gunther Mayer <gunther.mayer@gmx.net>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
Message-ID: <20020315174916.GE27706@higherplane.net>
In-Reply-To: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu> <E16kW0A-0001Yl-00@the-village.bc.nu> <20020313125507.C38@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020313125507.C38@toy.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 12:55:07PM +0000, Pavel Machek wrote:
> Hi!
> 
> > > Umm...  By what magic?  The entire interface _is_ root-only, isn't it?
> > > And root can do a lot of fun stuff, starting with editing the kernel
> > > image...
> > 
> > No argument there.
> > 
> > Do we want to assume all raw commands are CAP_SYS_RAWIO or break them down
> > a bit ?
> 
> As noone seriously uses capabiities, anyway, I guess CAP_SYS_RAWIO for all
> is ok.

i believe the next debian (after the one currently stabilizing for
release) has "real" use of capabilities as a major goal although that
was hearsay and may be entirely false.  the amount of work involved is
not insignificant

it'd certainly be a good thing to see.  after all these years of slowly
converting things to use CAP_SYS_* instead of uid==0 i certainly don't
want that effort to be wasted.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
