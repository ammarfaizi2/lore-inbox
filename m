Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbTFQVFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTFQVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:05:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63961 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264977AbTFQVFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:05:16 -0400
Date: Tue, 17 Jun 2003 14:14:43 -0700 (PDT)
Message-Id: <20030617.141443.24610277.davem@redhat.com>
To: girouard@us.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFDF06338E.06BC4D08-ON85256D48.00729284@us.ibm.com>
References: <OFDF06338E.06BC4D08-ON85256D48.00729284@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice Girouard <girouard@us.ibm.com>
   Date: Tue, 17 Jun 2003 15:57:59 -0500
   
   Did I understand:
   
   > 1) Chip has a "flow cache", LRU based, managed like routing caches
   
   You need the chip to support your technique.

No shit Sherlock.

But it should be noted that the idea can be fully verified in software
by adding the scheme into the RX processing of some existing ethernet
driver.

   Are the vendors picking up on this?

If they're going to ignore my ideas, that's not my problem.

   I still don't see how this gets rid of the copy_to_user space once
   you've gathered the buffers.  How do you feed the user buffer addresses to
   the card?

You flip the pages into userspace, ie. you replace the page the user
currently has with the one the networking buffer is using.

   What technique are you using?  Is it proprietary?

ROFL!
