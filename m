Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVAXVeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVAXVeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVAXVdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:33:32 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:19623 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261672AbVAXVcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:32:08 -0500
Message-ID: <41F56949.3010505@ens-lyon.fr>
Date: Mon, 24 Jan 2005 22:31:53 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
References: <20050124021516.5d1ee686.akpm@osdl.org> <41F4E28A.3090305@ens-lyon.fr> <20050124185258.GB27570@redhat.com> <20050124204458.GD27570@redhat.com>
In-Reply-To: <20050124204458.GD27570@redhat.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones a écrit :
> Here's the most obvious bug fixed. There still seems to be
> something wrong however. It only successfully boots 50% of the
> time for me, (it reboots when starting X otherwise), and when
> it does boot, I get a flood of ...
> Warning: kfree_skb on hard IRQ cf7b5800
> Warning: kfree_skb on hard IRQ cf7b5800
> Warning: kfree_skb on hard IRQ cf7b5800
> 
> I think there may be some stupid memory corruptor bug in there still.
> 
> 		Dave

Thanks, your patch makes X work again with DRI.
Actually, it successfully booted 100% of the time here.
I tried 6 or 7 times without seeing any problem like yours.
Let me know if you want me to try something special.

Brice
