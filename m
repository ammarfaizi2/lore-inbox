Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbSLNJxz>; Sat, 14 Dec 2002 04:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbSLNJxz>; Sat, 14 Dec 2002 04:53:55 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:23947 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267564AbSLNJxy>;
	Sat, 14 Dec 2002 04:53:54 -0500
Date: Sat, 14 Dec 2002 10:01:25 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: GrandMasterLee <masterlee@digitalroadkill.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021214100125.GA30545@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mike Dresser <mdresser_l@windsormachine.com>,
	GrandMasterLee <masterlee@digitalroadkill.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0212132319280.29293-100000@router.windsormachine.com> <Pine.LNX.4.33.0212132345040.12319-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212132345040.12319-100000@router.windsormachine.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 11:53:51PM -0500, Mike Dresser wrote:
 > On Fri, 13 Dec 2002, Mike Dresser wrote:
 > 
 > > The single P4/2.53 in another machine can haul down in 3m17s
 > >
 > Amend that to 2m19s, forgot to kill a background backup that was moving
 > files around at about 20 meg a second.

Note that there are more factors at play than raw cpu speed in a
kernel compile. Your time here is slightly faster than my 2.8Ghz P4-HT for
example.  My guess is you have faster disk(s) than I do, as most of
the time mine seems to be waiting for something to do.

*note also that this is compiling stock 2.4.20 with default configuration.
The minute you change any options, we're comparings apples to oranges.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
