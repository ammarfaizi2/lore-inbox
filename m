Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131820AbRDJOI4>; Tue, 10 Apr 2001 10:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRDJOIq>; Tue, 10 Apr 2001 10:08:46 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:19466 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131820AbRDJOId>;
	Tue, 10 Apr 2001 10:08:33 -0400
Date: Tue, 10 Apr 2001 16:08:25 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: richard offer <offer@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010410160825.A20555@pcep-jamie.cern.ch>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com> <20010408161620.A21660@flint.arm.linux.org.uk> <3AD0A029.C17C3EFC@rcn.com> <9aqmgo$8f6ol$1@fido.engr.sgi.com> <10104091601.ZM401478@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10104091601.ZM401478@sgi.com>; from offer@sgi.com on Mon, Apr 09, 2001 at 04:01:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

richard offer wrote:
> uname does not always provide useful information (cross compiling). Even
> if you're building the same ISA, you maybe in a chroot'ed environment.
> 
> Can we please not assume that everybody only ever builds native...

Nobody is assuming that.  If you're hard enough to do a cross compile,
you can build external modules using "make KERNEL_RELEASE=2.4.2
KERNEL_SOURCE=/home/jamie/cross_compiling/kernel ARCH=mips64" or
whatever.

-- Jamie
