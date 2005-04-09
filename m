Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVDIAFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDIAFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 20:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDIAFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 20:05:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:37867 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261208AbVDIAFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 20:05:08 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <jezmw9ug7j.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	 <1112923186.9567.349.camel@gaston>  <jezmw9ug7j.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 10:03:25 +1000
Message-Id: <1113005006.9568.402.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This patch adds to the fbdev interface a set_cmap callback that allow
> > the driver to "batch" palette changes. This is useful for drivers like
> > radeonfb which might require lenghtly workarounds on palette accesses,
> > thus allowing to factor out those workarounds efficiently.
> 
> This makes it better. But there is still a delay of half a second, and
> there is an annoying flicker when switching from X to the console.

Can you redo the counting of the workarounds with the patch ?

Ben.


