Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWAGWZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWAGWZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbWAGWZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 17:25:30 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:59067 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1161026AbWAGWZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 17:25:30 -0500
Date: Sat, 7 Jan 2006 18:17:18 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken configs
Message-ID: <20060107231718.GA12226@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060105161436.GA4426@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr> <200601061801.17497.rob@landley.net> <20060107023713.GA13285@ccure.user-mode-linux.org> <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 04:12:50PM +0100, Jan Engelhardt wrote:
> So there is no way to get UML compile on non-Linux.

Umm, no.  We're describing how it works on Linux.  That doesn't mean it
only can work on Linux.

The libc-dependent code movement which has been going into mainline is part
of making UML use VT (Intel hardware virtualization support), where the
runtime environment is different enough that it makes sense to handle this
as a port to a new OS.

There was also a nearly complete Windows port a few years ago which has
bitrotted since.

				Jeff
