Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbSKOSDU>; Fri, 15 Nov 2002 13:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSKOSDT>; Fri, 15 Nov 2002 13:03:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38628 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266848AbSKOSDS>;
	Fri, 15 Nov 2002 13:03:18 -0500
Date: Fri, 15 Nov 2002 13:10:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: "chandrasekhar.nagaraj" <chandrasekhar.nagaraj@patni.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Path Name to kdev_t
In-Reply-To: <20021115161536.GA6654@reti>
Message-ID: <Pine.GSO.4.21.0211151308560.17102-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Nov 2002, Joe Thornber wrote:

> On Thu, Nov 14, 2002 at 07:19:16PM +0530, chandrasekhar.nagaraj wrote:
> > Hi,
> > 
> > In one of the part of my driver module , I have a path name to a device file
> > (for eg:- /dev/hda1) .Now if I want to obtain the associated major number
> > and minor number i.e. device ID(kdev_t) of this file what would be the
> > procedure?
> 
> I think this should be standard function, I'm sure lots of people are
> duplicating this code.  For 2.4 kernels:

No, it really shouldn't.  You should _NOT_ mess with kdev_t - use real
objects instead.

