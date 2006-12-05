Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968575AbWLEScI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968575AbWLEScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968612AbWLEScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:32:08 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2676 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968575AbWLEScF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:32:05 -0500
Date: Tue, 5 Dec 2006 18:31:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, art@usfltd.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19 git compile error - "current_is_keventd" [drivers/net/phy/libphy.ko]
 undefined 
In-Reply-To: <Pine.LNX.4.64.0612041934270.3476@woody.osdl.org>
Message-ID: <Pine.LNX.4.64N.0612051824310.7108@blysk.ds.pg.gda.pl>
References: <200612050129.kB51TBaC027403@laptop13.inf.utfsm.cl>
 <Pine.LNX.4.64.0612041934270.3476@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Linus Torvalds wrote:

> > Also i686, sparc64. At drivers/net/phy/phy.c:590 is the lone reference to
> > current_is_keventd in that directory.  Still present as of ff51a9...
> 
> Yeah, I'm waiting for this whole mess to be either explained or reverted. 
> There are apparently bigegr issues with it than just the butt-ugly 
> "current_is_keventd()" crud.

 I am very surprised indeed "the mess" has been applied at all in the 
first place.  The conclusion of the discussion a while ago was to sort out 
the issue within libphy.  The change should be reverted.

  Maciej
