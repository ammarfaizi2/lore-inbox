Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVLAJvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVLAJvj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 04:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVLAJvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 04:51:39 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17086
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932123AbVLAJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 04:51:39 -0500
Date: Thu, 01 Dec 2005 01:51:15 -0800 (PST)
Message-Id: <20051201.015115.49187117.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: dwmw2@infradead.org, vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [NET] Remove ARM dependency for dm9000 driver
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051201094111.GA14726@flint.arm.linux.org.uk>
References: <20051130190224.GE1053@flint.arm.linux.org.uk>
	<1133426199.4117.179.camel@baythorne.infradead.org>
	<20051201094111.GA14726@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 1 Dec 2005 09:41:11 +0000

> In which case why do we restrict floppy to only those machines which
> could have floppy?  Why do we restrict IDE to only those platforms
> which may have IDE?

These two examples require platform level support via
an asm/*.h header file.

Whereas the driver's we are talking about use portable
interfaces that should be available across the board.

So, bad example.
