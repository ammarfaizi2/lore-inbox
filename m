Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLPTO1>; Mon, 16 Dec 2002 14:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbSLPTO1>; Mon, 16 Dec 2002 14:14:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61331 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261286AbSLPTO0>;
	Mon, 16 Dec 2002 14:14:26 -0500
Date: Mon, 16 Dec 2002 19:21:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: Xavier LaRue <paxl@videotron.ca>, linux-kernel@vger.kernel.org
Subject: Re: L2 Cache problem
Message-ID: <20021216192158.GI15256@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mike Dresser <mdresser_l@windsormachine.com>,
	Xavier LaRue <paxl@videotron.ca>, linux-kernel@vger.kernel.org
References: <20021216133016.64c75cac.paxl@videotron.ca> <Pine.LNX.4.33.0212161347580.25857-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212161347580.25857-100000@router.windsormachine.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 01:56:09PM -0500, Mike Dresser wrote:
 > > my dmesg will be online at http://paxl.no-ip.org/~paxl/dmesg.txt if somone mind.
 > > Another fuzzy thing .. compiling my kernel normaly ( -j 1 ) take 30min
 > > and when I make it with -j 2/8/16 it take 25min, I think this is due to
 > > my L2 cache problem but that not normal, if somone have an idea.. I
 > > should be realy interested.
 > sounds like you've got your l2 turned off in the bios to me.

2.4 right up until .21pre1 has a bug in the cache sizing routine.
It should be fixed now.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
