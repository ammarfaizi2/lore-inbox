Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbTLIUmg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbTLIUmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:42:36 -0500
Received: from aun.it.uu.se ([130.238.12.36]:3505 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266150AbTLIUmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:42:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16342.13236.198024.714840@alkaid.it.uu.se>
Date: Tue, 9 Dec 2003 21:42:28 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <9cfiskqjb99.fsf@rogue.ncsl.nist.gov>
References: <20031207110122.GB13844@zombie.inka.de>
	<Pine.LNX.4.58.0312070812080.2057@home.osdl.org>
	<br28f2$fen$1@gatekeeper.tmr.com>
	<200312081753.hB8HrQfD019477@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0312081046200.13236@home.osdl.org>
	<200312081940.hB8Je8fD023223@turing-police.cc.vt.edu>
	<9cfiskqjb99.fsf@rogue.ncsl.nist.gov>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff writes:
 > Valdis.Kletnieks@vt.edu writes:
 > 
 > > The stuff that supports LABEL= on a partition is a *partial*
 > > solution to decouple the name of the device as the system found it
 > > from a logical name, but as many have noted, it has its own issues.
 > 
 > Yes, labels and UUIDs are great for those of us with lots of SCSI
 > devices, so that adding a controller or changing a cable doesn't
 > require _two_ boots (one to figure out where everything went and edit
 > /etc/fstab, one for real).
 > 
 > I wish I could LABEL swap partitions.

In March 2001 I posted a patch for util-linux to support that:
http://www.csd.uu.se/~mikpe/linux/swap-label/swap-label-patch-2001-03-15

There was only minor interest in the thing, so I've not
pursued it any further.
