Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSDURON>; Sun, 21 Apr 2002 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313630AbSDUROM>; Sun, 21 Apr 2002 13:14:12 -0400
Received: from bitmover.com ([192.132.92.2]:2203 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313628AbSDUROL>;
	Sun, 21 Apr 2002 13:14:11 -0400
Date: Sun, 21 Apr 2002 10:14:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Jochen Friedrich <jochen@scram.de>, Larry McVoy <lm@bitmover.com>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jeff Garzik <garzik@havoc.gtf.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421101410.C10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Jochen Friedrich <jochen@scram.de>, Larry McVoy <lm@bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020421120820.040107b0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0204211844260.18496-100000@alpha.bocc.de> <5.1.0.14.2.20020421175855.00aed8d0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Sun, Apr 21, 2002 at 06:05:43PM +0100, Anton Altaparmakov wrote:
> Then use BK over email then (to submit a patch of your last change set for 
> example you would do "bk export -tpatch -r+", and the receiving end does a 
> simple "cat emailmessagetext | bk receive" and that's it done.

This is almost right and I can see there is some confusion, so here's
son technical info in the midst of this, err, "discussion" :-)

If you want to send a regular style patch

	bk export -tpatch -r+		# send most recent changeset
	bk import -tpatch		# accept regular patch

If you want to send BK style patches

	bk send user@host.com
	bk receive

NOTE! bk send will send *everything* it has not already sent to that 
email address, i.e., the whole tree.  See the "bk help send" docs for
info on how to tell BK that the user already has part of the tree.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
