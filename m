Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSJAPkS>; Tue, 1 Oct 2002 11:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbSJAPkS>; Tue, 1 Oct 2002 11:40:18 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:49540 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261757AbSJAPkR>;
	Tue, 1 Oct 2002 11:40:17 -0400
Date: Tue, 1 Oct 2002 16:48:08 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: venom@sns.it
Cc: Alexander Viro <viro@math.psu.edu>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
Message-ID: <20021001154808.GD126@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
	Alexander Viro <viro@math.psu.edu>,
	Joe Thornber <joe@fib011235813.fsnet.co.uk>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.GSO.4.21.0210011010380.4135-100000@weyl.math.psu.edu> <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0210011650490.12465-100000@cibs9.sns.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 04:52:44PM +0200, venom@sns.it wrote:
 > A Logical Volume Manager is needed on Unix servers, and so it is needed
 > also on Linux.
 > If this LVM is obsoleted, then when will LVM2 be merged?
 > really we cannot have a 2.6 or 3.0 tree without a Volume Manager, it would
 > be a big fault.

No-one suggested 2.6.0 shipping without /something/, but having a dead
LVM1 in _2.5_ doesn't help anyone. We've gone 6 months with it being in
a broken/uncompilable state, going another month without it isn't a big
deal. Getting something in before halloween is however a goal the
Sistina folks should be aiming for.

Consider it patch 1/2 of the device mapper merge 8-)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
