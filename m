Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUIXQgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUIXQgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUIXQfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:35:53 -0400
Received: from mr4.cc.ic.ac.uk ([155.198.5.114]:63153 "EHLO mr4.cc.ic.ac.uk")
	by vger.kernel.org with ESMTP id S268851AbUIXQQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:16:55 -0400
Date: Fri, 24 Sep 2004 17:16:54 +0100 (BST)
From: Kostas Georgiou <k.georgiou@imperial.ac.uk>
X-X-Sender: georgiou@heppc218.hep.ph.ic.ac.uk
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] matroxfb big-endian update (was Re: [PATCH] ppc64: Fix
 __raw_* IO accessors)
In-Reply-To: <20040924095348.GA30132@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.58.0409241658150.26295@heppc218.hep.ph.ic.ac.uk>
References: <523c1bpghm.fsf@topspin.com> <Pine.LNX.4.58.0409211237510.25656@ppc970.osdl.org>
 <52mzzjnuq7.fsf@topspin.com> <Pine.LNX.4.58.0409211510150.25656@ppc970.osdl.org>
 <1095816897.21231.32.camel@gaston> <20040922185851.GA11017@vana.vc.cvut.cz>
 <1095900539.6359.46.camel@gaston> <20040923152530.GA9377@vana.vc.cvut.cz>
 <20040923202601.GA6586@vana.vc.cvut.cz> <1096007137.4009.38.camel@gaston>
 <20040924095348.GA30132@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Petr Vandrovec wrote:

> XFree 3.x did not touch BE mode bit and accessed MMIO directly with pointer 
> dereference (expecting firmware to put card into BE mode?), while XFree 4.x (if
> I understand code properly) does not touch BE bit on primary device
> (while it clears it on secondary devices) while expecting hardware to be
> in LE mode...
> 
> So I'm either confused, or XF3 needs BE_ACCEL set while XF4 needs BE_ACCEL
> disabled.  Does anybody actually use matroxfb with XFree server on PPC (or any
> other BE machine) at all?

We had almost the same discussion 4 years ago :) 
Have a look at: http://lists.debian.org/debian-powerpc/2001/01/msg00443.html

The driver in XFree 3.x never worked under ppc so don't worry about it.

Kostas
