Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFQWWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFQWWQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVFQWWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:22:16 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:58839 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261171AbVFQWWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:22:12 -0400
Message-ID: <42B34D12.70008@g-house.de>
Date: Sat, 18 Jun 2005 00:22:10 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: forcedeth as a module only?
References: <200506171804.j5HI4qoh027680@dbl.q-ag.de> <42B31749.90208@g-house.de> <42B336FC.9000400@colorfullife.com>
In-Reply-To: <42B336FC.9000400@colorfullife.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul schrieb:
> Very interesting.  The message itself is not fatal: It merely means that
> there was no link during ifup. This typically happens when the hardware
> initialization was not yet finished during ifup. Theoretically, an
> interrupt should happen when the hardware initialization is completed
> and that interrupt then sets up the link.
> Somehow it doesn't work for you.

could be the hardware's fault too? it's an onboard NIC on an nforce
chipset and the lspci i attached in the last mail looks rather strange
(compared to the r8169 (eth1) entry).

> Could you try the attached patch? It polls for link changes instead of
> relying on the irq. Additionally, I have enabled some debug output.

off to reboot in a second...


thanks,
Christian.

PS: on a side note, did you get my "other" mail concerning your mail address?
-- 
BOFH excuse #122:

because Bill Gates is a Jehovah's witness and so nothing can work on St.
Swithin's day.
