Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSJCQoJ>; Thu, 3 Oct 2002 12:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbSJCQoJ>; Thu, 3 Oct 2002 12:44:09 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:24461 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261228AbSJCQoJ>;
	Thu, 3 Oct 2002 12:44:09 -0400
Date: Thu, 3 Oct 2002 17:51:42 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice)
Message-ID: <20021003165142.GA25316@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, akpm@digeo.com
References: <200210031551.g93FpwsR000330@darkstar.example.net> <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 08:57:13AM -0700, Linus Torvalds wrote:

 > The memory management issues would qualify for 3.0, but my argument there 
 > is really that I doubt everybody really is happy yet. Which was why I 
 > asked for people to test it and complain about VM behaviour - and we've 
 > had some ccomplaints ("too swap-happy") although they haven't sounded like 
 > really horrible problems.

We still need some work for low memory boxes (where low isn't
necessarily all that low). On my 128MB laptop I can lock up the box
for a minute or two at a time by doing two things at the same time,
like a bk pull, and switching desktops.

I dread to think how a 16 or 32MB box performs these days..

		Dave				

-- 
| Dave Jones.        http://www.codemonkey.org.uk
