Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282317AbRK2DBI>; Wed, 28 Nov 2001 22:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282316AbRK2DA6>; Wed, 28 Nov 2001 22:00:58 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:11408 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S282317AbRK2DAs>; Wed, 28 Nov 2001 22:00:48 -0500
Date: Wed, 28 Nov 2001 22:03:29 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
Message-ID: <20011128220329.A2718@earthlink.net>
In-Reply-To: <20011128212429.A155@earthlink.net> <Pine.GSO.4.21.0111282130310.8990-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0111282130310.8990-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Nov 28, 2001 at 09:32:43PM -0500
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 09:32:43PM -0500, Alexander Viro wrote:
> Umm...  With which patch?  Sorry for being dense, but I see no patches

Oops.

[PATCH] fix for drivers/char/pc_keyb.c in 2.5.1-pre3

2.5.1-pre3 would not compile without Alan's patch for pc_keyb.c, etc.

I also noticed the logfile LTP "runalltests" was writing to has binary 
data and snippets of kernel code in it.  (Normally it would all be text).

This was on a reiserfs system, btw.

-- 
Randy Hron

