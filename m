Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbSI3LFe>; Mon, 30 Sep 2002 07:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbSI3LFe>; Mon, 30 Sep 2002 07:05:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:2321 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262017AbSI3LF2>; Mon, 30 Sep 2002 07:05:28 -0400
Date: Mon, 30 Sep 2002 04:10:45 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice driver
Message-ID: <20020930111045.GB7967@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com> <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain> <20020928091634.GC32017@pegasys.ws> <200209300911.g8U9BKp18642@Port.imtp.ilyichevsk.odessa.ua> <20020930102228.GB28157@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020930102228.GB28157@louise.pinerecords.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 12:22:28PM +0200, Tomas Szepe wrote:
> > Technically correct. Major version jump should be made when there is
> > a binary incompatibility. It can be made without, but it is usually
> > done for marketing reasons. I hope we'll never have marketing reasons
> > for lk. :-) We can be actually _proud_ to have 2.$BIGNUM instead of
> > 3.0
> 
> ... and go Solaris, as in 2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 7, 8, 9.  :D

I've no problem per-se with 2.6, 2.7, 2.8, 2.9, 2.10...
And i see no reason to compare it with Solaris where numbers
are mostly marketing although their major number refereed to
the codebase (bsd vs SVr4).

I can see a number of real reasons to advance to 3.x:
Finishing the block layer and VM rewrite, maybe;
making FS blocksize independent of pagesize, probably;
flexibility with regard to pagesize for archs that support
variable pagesize (if market share and performance gains add
up the CPU designers will give it to us), probably;
initramfs, perhaps;
new module interface, possibly;
hotplug everything (and i mean everything), maybe;
elimination of the 32 bit versions of system-calls
and other deprecated interfaces, absolutely;
new filesystems and device drivers, nope;  
incremental performance improvements, you've got to be kidding;

It is just that right now, from what little i can see, 2.5
is part way through the process of a block layer redesign
and the VM is in a similar state.  Evidently LVM is in limbo
but that has to be at least operational before code freeze.
Driverfs looks promising but the API isn't even set and
documented yet.  BTW what happened to moving away from
major/minor numbers?

The developers are doing a great job and things are moving
along but 2.6 looks more than anything else like a stabilized
snapshot so the improvements become available (trustworthy)
for production.  That is consistent with "release early,
release often".



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
