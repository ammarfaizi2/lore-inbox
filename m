Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTE3Cs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 22:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTE3Cs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 22:48:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46763 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262298AbTE3Cs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 22:48:58 -0400
Date: Thu, 29 May 2003 20:01:01 -0700 (PDT)
Message-Id: <20030529.200101.118622651.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
References: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Thu, 29 May 2003 12:09:54 -0400

   the three following changesets attempt to bring the he atm
   driver into conformance with the accepted linux coding style,
   fix some chattiness the irq handler, and address the stack
   usage issue in he_init_cs_block_rcm().

Applied, thanks.

You can integrate ideas posted in this thread in subsequent
patches.

BTW, can you use more consistent changeset messages?  I always
at least allude to what is being changed, for example I changed
all of your messages to be of the form:

	[ATM]: Blah blah blah in HE driver.

This tells the reader that:

1) It's an ATM change.

2) It's to the HE driver.

3) The change made was "Blah blah blah" :-)
