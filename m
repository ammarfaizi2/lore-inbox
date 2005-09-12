Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVILWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVILWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVILWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:11:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54953
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932291AbVILWLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:11:15 -0400
Date: Mon, 12 Sep 2005 15:11:20 -0700 (PDT)
Message-Id: <20050912.151120.104514011.davem@davemloft.net>
To: naked@iki.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: netfilter QUEUE target and packet socket interactions buggy or
 not
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
References: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuutti Kotivuori <naked@iki.fi>
Date: Tue, 13 Sep 2005 01:12:26 +0300

> ,----
> | Unable to handle kernel NULL pointer dereference at virtual address 00000018
> | ...
> |         __kfree_skb+0xf4/0xf7
> |  [<c02c3188>] packet_rcv+0x2ca/0x2d4
> |  [<f888f792>] bcm5700_start_xmit+0x477/0x4a5 [bcm5700]

Please use the tg3 driver that actually comes with
the kernel :-)
