Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUAZHKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 02:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUAZHKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 02:10:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34758 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261967AbUAZHKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 02:10:03 -0500
Date: Sun, 25 Jan 2004 23:01:02 -0800 (PST)
Message-Id: <20040125.230102.71560587.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sungem: add support for G5 PowerMac, some PM fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1074813192.949.121.camel@gaston>
References: <1074750642.974.109.camel@gaston>
	<20040121220823.63d46968.davem@redhat.com>
	<1074813192.949.121.camel@gaston>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
   Date: Fri, 23 Jan 2004 10:13:12 +1100

   Anyway, here's the fixed version.

Applied, thanks.  This one might have to wait for 2.6.3-pre1 though
for merging.

   The 2.4 backport will come next week hopefully when I'll walk
   through all my pending 2.4 stuffs, I want to dbl check a few things
   in it first (and I'm not yet 100% certain I will merge the G5
   support in 2.4 upstream anyway).

You should be able to literally copy the 2.6.x driver into the 2.4.x
tree with perhaps only a one liner or two (if that).

   the new PCI ID isn't yet in Linus tree, but it's in the patches
   I'm currently sending to Andrew.

I'd prefer in the future you not do it this way, just give it
instead within the driver update so that you patch by itself
stands alone.

Thanks.
