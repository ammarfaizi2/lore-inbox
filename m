Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272718AbTHENf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272726AbTHENf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:35:27 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:29153 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272718AbTHENfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:35:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16175.45710.993756.301205@gargle.gargle.HOWL>
Date: Tue, 5 Aug 2003 15:35:10 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, heine@instmath.rwth-aachen.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: time for some drivers to be removed?
In-Reply-To: <20030805130324.GC16091@fs.tum.de>
References: <200308051242.h75CgSj6028203@harpo.it.uu.se>
	<20030805130324.GC16091@fs.tum.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > On Tue, Aug 05, 2003 at 02:42:28PM +0200, Mikael Pettersson wrote:
 > > On 27 Jul 2003 21:56:11 +0100, Alan Cox wrote:
 > > > On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
 > > > > That's no problem for me.
 > > > > 
 > > > > The only question is how to call the option that allows building only on
 > > > > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
 > > > > would you suggest OBSOLETE_ON_SMP?
 > > > 
 > > > Interesting question - whatever I guess. We don't have an existing convention.
 > > > How many drivers have we got nowdays that failing on just SMP ?
 > > 
 > > ftape fails on SMP due to sti/save_flags/restore_flags removal.
 > >...
 > > I have the HW so I can test patches if someone feels like fixing this.
 > 
 > There seems to be an upgrade f the ftape code available at [1], but I 
 > haven't investigated on the status or plans to integrate it into 2.6.

ftape-4.04? That's been a non-integrated external package for ages and ages.
I doubt there's been any updates in it for 2.5/2.6 kernels.

I used to use ftape-4 snapshots in late 2.1 and most 2.2 kernels, but patch
maintenance overhead made me go back to the kernel's ftape before 2.4.0.

Given how few still use these antiques (my "fast" Conner/Seagate drive gives
150KBps backup speed, wow!) I think simply maintaining status quo is the most
reasonable use of peoples' time.
