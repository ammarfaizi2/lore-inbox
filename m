Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbWKEX1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbWKEX1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWKEX1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:27:11 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19874
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932604AbWKEX1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:27:10 -0500
Date: Sun, 05 Nov 2006 15:27:18 -0800 (PST)
Message-Id: <20061105.152718.88476049.davem@davemloft.net>
To: kaber@trash.net
Cc: joro-lkml@zlug.org, jdi@l4x.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
From: David Miller <davem@davemloft.net>
In-Reply-To: <454E671B.2090302@trash.net>
References: <45301CB3.4060803@l4x.org>
	<20061014093255.GA4646@zlug.org>
	<454E671B.2090302@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Sun, 05 Nov 2006 23:35:07 +0100

> It would be nice to keep things working even with this built as a
> module, it took me some time to realize my IPv6 tunnel was broken
> because of the missing sit module. This module alias fixes things
> until distributions have added an appropriate alias to modprobe.conf.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>

Would you like me to apply this or is this a temp workaround
for folks?

