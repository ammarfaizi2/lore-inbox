Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUEAQ0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUEAQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUEAQ0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:26:46 -0400
Received: from [12.177.129.25] ([12.177.129.25]:48323 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262311AbUEAQ0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 12:26:45 -0400
Date: Sat, 1 May 2004 13:09:05 -0400
From: Jeff Dike <jdike@addtoit.com>
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@sourceforge.net
Subject: [PATCH] UML/x86_64
Message-ID: <20040501170905.GA7655@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML has been ported to x86_64.  The patch for 2.6.4 is available at
	http://www.user-mode-linux.org/mirror/uml-patch-x86-64-2.6.4.bz2

Note that this is separate from the 2.6.4 UML patch, and must be
applied to a 2.6.4 + uml-patch-2.6.4 tree.  It will remain separate
until I get it all merged cleanly into my tree.  At that point, the
separate x86_64 patch will disappear.

This patch is fairly nasty in places, and the build is also fairly
unclean, so avert your eyes if you are squeamish.  This will get
better as I merge it into my pool.

The nastiness aside, it does build and you do get a robust UML.

My thanks go to PathScale (pathscale.com) for sponsoring this work and
providing access to hardware to make it possible.

Finally, as I do the merge (and afterwards), I need access to an
Opteron to make sure I don't break this port.  So, if anyone has such
a box that I can have access to, let me know.

				Jeff
