Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263641AbTIHUmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbTIHUmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:42:17 -0400
Received: from toq7-srv.bellnexxia.net ([209.226.175.203]:4055 "EHLO
	toq7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263641AbTIHUmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:42:15 -0400
Date: Mon, 8 Sep 2003 11:40:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: problem with "Gadget filesystem" config prompt (bk10)
Message-ID: <Pine.LNX.4.44.0309081137260.15517-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  just doing a "make oldconfig", from bk9 -> bk10, being prompted for the
USB_GADGETFS (Gadget filesystem), which asks

  ... [N/m/?]  (NEW)

without thinking, i typed "y" (not noticing that that was not a valid
answer), and what i got back was:

Say "y" to link the driver statically, or "m" to build a
dynamically linked module called "gadgetfs".

  which suggests that "y" *is* a valid response (when clearly it isn't).  
someone might want to clarify this.

rday

