Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTAaXzz>; Fri, 31 Jan 2003 18:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263544AbTAaXzz>; Fri, 31 Jan 2003 18:55:55 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:62140 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S263491AbTAaXzy>;
	Fri, 31 Jan 2003 18:55:54 -0500
Date: Sat, 1 Feb 2003 01:05:20 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
Message-ID: <20030201000520.GA4200@werewolf.able.es>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es> <3E3B066B.8010905@pobox.com> <20030131234021.GE1541@werewolf.able.es> <Pine.LNX.4.44.0302010058300.9900-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0302010058300.9900-100000@serv>; from zippel@linux-m68k.org on Sat, Feb 01, 2003 at 01:01:55 +0100
X-Mailer: Balsa 2.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.02.01 Roman Zippel wrote:
> Hi,
> 
> On Sat, 1 Feb 2003, J.A. Magallon wrote:
> 
> > The easies way (from my point of view): write Perl::KConfig in C to do the logic
> > hard work and build the big thing in perl. That will be putting a perl
> > interface on top of klibc ?
> 
> You gain _nothing_ by rewritting it in perl. The backend is already a 
> library and a swig interface file exists, so it's already trivial to 
> generate Perl::KConfig. There is absolutely no reason to force people to 
> use perl.
> 

No, that was exactly what I tried to say, take nowadays C library, and build
a loadable module for perl (it has not to be written in perl). 

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre4-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-5mdk))
