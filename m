Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSLDLuu>; Wed, 4 Dec 2002 06:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbSLDLuu>; Wed, 4 Dec 2002 06:50:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3091 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266417AbSLDLut>;
	Wed, 4 Dec 2002 06:50:49 -0500
Date: Wed, 4 Dec 2002 11:58:19 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021204115819.GB1137@gallifrey>
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203121521.GB30431@suse.de>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 11:48:45 up 50 min,  1 user,  load average: 0.09, 0.41, 0.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@codemonkey.org.uk) wrote:

> - architecture xxx doesn't compile
>   there's a few of these now in bugzilla, and personally I don't think
>   they belong there. Any arch other than i386 is always going to be
>   playing catchup, and is nearly always out of date in mainline.

Quite a few of those are from me.  It is a real pity that we keep the
view of everything other than i386 is playing catch up - that really
deminishes the usefulness of Linux in a lot of fields.

Don't forget that ia64, x86-64 and s390 are all potentially growing
users of Linux.  Linux on ARM, MIPS and PPC also has a healthy band of
productive (commercial and home) users.

The problem for a lot of the users of some of these architectures is that they
have to have a long hard fight to get a kernel to work on their system;
and every one of the systems has to have a different kernel version with
different oddities.  The stability of these systems isn't just harmed by
the fact that less people are testing the architecture specific code but
also that they tend to be based on older original kernel trees.

In addition porting to another architecture is a great way to shake out
pointer bugs and random bugs in any code - so being able to run the main
kernel on a few architectures should help make life more stable for
everyone.

I don't expect that all the other architectures will be as well tested
as x86; but at least we should know the state of each architecture and
preferably have 2.6.x (or whatever it gets called) to basically work on
as many architectures as possible.

When Linux does work accross lots of architectures it is very, very
useful - how many other OS's can give you the same operating environment
on totally different pieces of hardware? It makes porting code very
simple and pleasent when you only have to worry about the architectural
differences and not battling between different OS.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
