Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTA2QOC>; Wed, 29 Jan 2003 11:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTA2QOC>; Wed, 29 Jan 2003 11:14:02 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34755 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266297AbTA2QOB>;
	Wed, 29 Jan 2003 11:14:01 -0500
Date: Wed, 29 Jan 2003 16:20:13 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no more MTRRs available ?
Message-ID: <20030129162013.GA1856@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030129164552.182e0cb8.skraw@ithnet.com> <Pine.LNX.4.44.0301291046490.18828-100000@coffee.psychology.mcmaster.ca> <20030129170554.08dc6393.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129170554.08dc6393.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 05:05:54PM +0100, Stephan von Krawczynski wrote:

 > Mark Hahn <hahn@physics.mcmaster.ca> wrote:

(odd, I'm not getting Mark's mails to l-k).
 
 > > that your bios is stupid, I think.  mtrr's handle areas that are 
 > > powers of two in size (and >= 1M, I think).  the problem here is that
 > > the bios is trying to represent 4G of write-back ram and a 16M of 
 > > uncachable IO area (AGP aperture, I'm guessing).  the correct way
 > > to do this is a single 4G mtrr with an overlapping 16M one.

That does seem to make more sense. Perhaps too much sense.
ISTR there were ordering rules in how you layer MTRRs on top of each
other.
 
		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
