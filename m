Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262784AbRE0HO7>; Sun, 27 May 2001 03:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbRE0HOt>; Sun, 27 May 2001 03:14:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15771 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262784AbRE0HOh>;
	Sun, 27 May 2001 03:14:37 -0400
Date: Sun, 27 May 2001 03:14:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Rankin <rankinc@pacbell.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5 and Reiserfs, oops!
In-Reply-To: <200105270657.f4R6vTU05995@wellhouse.underworld>
Message-ID: <Pine.GSO.4.21.0105270312430.1945-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Chris Rankin wrote:

> Well the first thing I checked was vanilla 2.4.5, and I managed to
> bring that down hard too. It has nothing at all to do with reiserfs,
> but may be related to USB instead. I have been able to reproduce the
> problem by doing the following:
> 
> a) Booting with X on vc/2
> b) Logging into vc/6 instead
> c) Mounting a filesystem on my USB Zip drive
> d) Unmounting the filesystem again
> e) Unmounting the NFS mount
> f) Executing "rmmod -a" twice to clean out the now-unused modules
> (e.g. sd_mod, scsi_mod, usb-storage)
> g) Trying to switch back to vc/2
> h) Oops!
> 
> 2.4.4 seems OK; I guess I'll have to build those -pre kernels now.

Interesting. See Pete's posting in thread about USB problems - it
may be related.

