Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277541AbRKDTyX>; Sun, 4 Nov 2001 14:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRKDTyF>; Sun, 4 Nov 2001 14:54:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30420 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275270AbRKDTxK> convert rfc822-to-8bit;
	Sun, 4 Nov 2001 14:53:10 -0500
Date: Sun, 4 Nov 2001 14:52:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011104204502.O14001@unthought.net>
Message-ID: <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, [iso-8859-1] Jakob Østergaard wrote:

> > If you feel it's too hard to write use scanf(), use sh, awk, perl
> > etc. which all have their own implementations that appear to have
> > served UNIX quite well for a long while.
> 
> Witness ten lines of vmstat output taking 300+ millions of clock cycles.

Would the esteemed sir care to check where these cycles are spent?
How about "traversing page tables of every damn process out there"?
Doesn't sound like a string operation to me...

