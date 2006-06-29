Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWF2TsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWF2TsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWF2TsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:48:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28651
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932353AbWF2TsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:48:21 -0400
Date: Thu, 29 Jun 2006 12:48:21 -0700 (PDT)
Message-Id: <20060629.124821.03110823.davem@davemloft.net>
To: snakebyte@gmx.de
Cc: eis@baty.hanse.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] SKB leak in drivers/isdn/i4l/isdn_x25iface.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <1151525167.26804.2.camel@alice>
References: <1151525167.26804.2.camel@alice>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>
Date: Wed, 28 Jun 2006 22:06:07 +0200

> hi,
> 
> coverity spotted this leak (id #613), when
> we are not configured, we return without
> freeing the allocated skb.
> 
> Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

Applied, thanks.
