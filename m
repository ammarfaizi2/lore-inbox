Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVFIWvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVFIWvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVFIWvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:51:22 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31417
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261470AbVFIWvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:51:14 -0400
Date: Thu, 09 Jun 2005 15:51:00 -0700 (PDT)
Message-Id: <20050609.155100.93023939.davem@davemloft.net>
To: nsankar@broadcom.com
Cc: gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] Another PCI fix for 2.6.12-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42A8C73C.6060005@broadcom.com>
References: <20050609222033.GA12580@kroah.com>
	<20050609.153254.74562706.davem@davemloft.net>
	<42A8C73C.6060005@broadcom.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Narendra Sankar" <nsankar@broadcom.com>
Date: Thu, 09 Jun 2005 15:48:28 -0700

> So it would still be useful to have this patch in, would it not?

Absolutely, the patch should go in.

I just want to make sure the descrepency between the two Broadcom
drivers gets resolved.  TG3 does a MSI correctness check, BNX2
does not.  And this is what doesn't make any sense.
