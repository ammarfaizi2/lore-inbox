Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbSI2QOZ>; Sun, 29 Sep 2002 12:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSI2QOY>; Sun, 29 Sep 2002 12:14:24 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31362 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262797AbSI2QOW>;
	Sun, 29 Sep 2002 12:14:22 -0400
Date: Sun, 29 Sep 2002 17:22:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929162221.GB19948@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <200209290114.15994.jdickens@ameritech.net> <Pine.LNX.4.44.0209290858170.22404-100000@innerfire.net> <20020929134620.GD2153@gallifrey> <20020929154254.GD1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929154254.GD1014@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 05:42:54PM +0200, Jens Axboe wrote:

 > Has anyone actually sent patches to Linus removing LVM completely from
 > 2.5 and adding the LVM2 device mapper? If I used LVM, I would have done
 > exactly that long ago. Linus, what's your oppinion on this?

Joe Thornber sent a patch removing LVM1, but LVM2 has yet to
make an appearance in 2.5.x patchform afair.  LVM is in one of
those sneaky positions where they could theoretically cheat
the feature freeze, as whats in the tree right now is fubar,
and we need /something/ before going 2.6/3.0.

It'd be nice to get /something/ in before the feature freeze so
people can bang on this after halloween when we ramp up stability
testing instead of waiting until the last minute.

There are some patches in -dj which make the existing LVM1 code
compile and 'sort of' work, but they're not fit for inclusion imo.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
