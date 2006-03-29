Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWC2Hz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWC2Hz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWC2Hz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:55:26 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61874
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751133AbWC2HzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:55:25 -0500
Date: Tue, 28 Mar 2006 23:55:40 -0800 (PST)
Message-Id: <20060328.235540.33323475.davem@davemloft.net>
To: nipsy@bitgnome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed at net/...
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060329075032.GF26340@king.bitgnome.net>
References: <20060329060816.GB26340@king.bitgnome.net>
	<20060328.234119.24811924.davem@davemloft.net>
	<20060329075032.GF26340@king.bitgnome.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Nipper <nipsy@bitgnome.net>
Date: Wed, 29 Mar 2006 01:50:33 -0600

>         Yes, it is an e1000.  I disabled TSO via ethtool.  Do I
> need to reboot or anything and do this right away to avoid
> problems or will the few assertions I've seen thus far not cause
> any badness in the kernel?

It should take effect right away, no need to reboot.
