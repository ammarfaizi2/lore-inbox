Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUKMXuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUKMXuf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKMXuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:50:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:39614 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261210AbUKMXub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:50:31 -0500
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041113112234.GA5523@bogon.ms20.nix>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
	 <200411090402.22696.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
	 <200411090608.02759.adaplas@hotpop.com>
	 <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
	 <20041112125125.GA3613@bogon.ms20.nix>
	 <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
	 <20041112191852.GA4536@bogon.ms20.nix> <1100309972.20511.103.camel@gaston>
	 <20041113112234.GA5523@bogon.ms20.nix>
Content-Type: text/plain
Date: Sun, 14 Nov 2004 10:49:32 +1100
Message-Id: <1100389772.20592.131.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-13 at 12:22 +0100, Guido Guenther wrote:

> > {in,out}_8 are ppc-specific things that are identical to readb/writeb
> > indeed, with barriers.

> In 2.6.10-rc1-mm5 {in,out}_8 and read/writeb are exactly identical, only
> __raw_{read,write}b is different. So you mean __raw_{read,write}b in the
> above? (no nitpicking, just want to be sure I understand this
> correctly).

I just meant they are identical and they have both barriers, sorry.

Ben.


