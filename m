Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282398AbRK2Gua>; Thu, 29 Nov 2001 01:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282357AbRK2GuV>; Thu, 29 Nov 2001 01:50:21 -0500
Received: from zeus.kernel.org ([204.152.189.113]:2178 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S282392AbRK2GuM>;
	Thu, 29 Nov 2001 01:50:12 -0500
Date: Thu, 29 Nov 2001 00:48:51 -0500
To: viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: fsync02 test hangs 2.5.1-pre3 + patch
Message-ID: <20011129004851.A113@earthlink.net>
In-Reply-To: <20011128220329.A2718@earthlink.net> <Pine.GSO.4.21.0111282303190.9271-100000@weyl.math.psu.edu> <20011129001859.B17852@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011129001859.B17852@earthlink.net>; from rwhron@earthlink.net on Thu, Nov 29, 2001 at 12:18:59AM -0500
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 12:18:59AM -0500, rwhron@earthlink.net wrote:
> > 	c) 2.5.1-pre3 + fs/super.c from 2.5.1-pre2
> > (fs/super.c changes are independent from everything else).
> 
> I'll try option c and let you know what happens.

I ran the fsync02 test by itself, and that went fine.  When I started
the "runalltests", the system locked up when "tail -f" showed fsync02.
It's possible that one of the next tests, fsync03 or ftruncate01 are 
the actual triggers for the "can't write" lockup.

-- 
Randy Hron

