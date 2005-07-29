Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVG2JtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVG2JtR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVG2Jrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:33 -0400
Received: from tim.rpsys.net ([194.106.48.114]:704 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262558AbVG2JrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:47:01 -0400
Subject: [patch 0/8] Corgi (Sharp Zaurus SL-c7x0) Driver Updates
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:23 +0100
Message-Id: <1122630383.7747.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of driver updates for the Sharp Zaurus SL-C7x0. All the
patches have been seen by the subsystem maintainers at some point. Some
of the input patches seem to be lost in the system (since March) and
given the mainline corgi keyboard code doesn't even compile at the
moment, I'd like to see some of these making mainline sooner rather than
later. The w100fb patch depends on the corgi touchscreen cleanup patch
which is why this hasn't been merged as yet. This patch series seems the
simplest way to resolve things.

Patches 1-7 only affect the Zaurus platform and are being used by Zaurus
users in preference to mainline kernels so merging makes a lot of sense
and should be minimal risk for anyone else. They're also all patches
against code I effectively maintain.

Patch 8 is the final key to resolving an input key vs. switch issue and
I'm happy to wait for the input maintainer to merge that if appropriate.
I've included it for completeness as previous versions that are around
are suffering bitrot.

Hopefully these are all good candidates for -mm and then mainline.

Richard
(Corgi Maintainer)


