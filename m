Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267634AbSLSKnz>; Thu, 19 Dec 2002 05:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267635AbSLSKny>; Thu, 19 Dec 2002 05:43:54 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:29598 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267634AbSLSKnw>;
	Thu, 19 Dec 2002 05:43:52 -0500
Date: Thu, 19 Dec 2002 10:50:10 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Freezing.. (was Re: Intel P6 vs P7 system call performance)
Message-ID: <20021219105010.GD29122@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>
References: <200212182237.gBIMbQmk000479@darkstar.example.net> <1040260157.26882.7.camel@irongate.swansea.linux.org.uk> <20021219003740.C20566@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021219003740.C20566@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 12:37:40AM +0000, Russell King wrote:
 > On Thu, Dec 19, 2002 at 01:09:17AM +0000, Alan Cox wrote:
 > > How the actual patches get applied really isnt relevant. I know Linus
 > > hated jitterbug, Im guessing he hates bugzilla too ?
 > 
 > I'm waiting for the kernel bugzilla to become useful - currently the
 > record for me has been:
 > 
 > 3 bugs total
 > 3 bugs for serial code for drivers I don't maintain, reassigned to mbligh.

That was unfortunate, and you got dumped with those because some thought
"Ah, serial! RMK!".  Some of the categories in bugzilla still need
broadening IMO.

 > This means I write (choose one):
 > 1. non-buggy code (highly unlikely)
 > 2. code no one tests
 > 3. code people do test but report via other means (eg, email, irc)
 > 
 > If it's (3), which it seems to be, it means that bugzilla is failing to
 > do its job properly, which is most unfortunate.

It's early days. The types of bugs being filed still fall into the
"useful" "not useful" categories though.  I don't think it's really
that important that we track what doesn't compile at this stage.
Those reports are being either closed within a few hours of them
being opened with a "Fixed in BK", or are drivers which no-one currently
wants to fix/can fix (Things like the various sti/cli breakage)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
