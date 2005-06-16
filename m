Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVFPXyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVFPXyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVFPXyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:54:23 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:41676 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261859AbVFPXyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:54:20 -0400
Message-ID: <42B21130.4000608@g-house.de>
Date: Fri, 17 Jun 2005 01:54:24 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Lars Roland <lroland@gmail.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <4ad99e0505061605452e663a1e@mail.gmail.com>	 <42B1F5CB.9020308@g-house.de> <4ad99e0505061615143cc34192@mail.gmail.com>
In-Reply-To: <4ad99e0505061615143cc34192@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Roland schrieb:
> It does not seams to be limited to braodcom cards. 3com and Intel e100
> cards does the exact same stunt on kernels never than 2.6.8.1. Intel
> e1000 and realtek 8139 cards do however work.

hm - tricky, i think. because no kernel oopses, nothing to look at in the
syslog (yes?), various nic drivers affected, others not...in cases like
these only Documentation/BUG-HUNTING comes to my mind: if 2.6.8.1 works,
and 2.6.12-rc6 does not, we'll need to find out the kernelversion which
introduced this behaviour.

sorry,
Christian.
-- 
BOFH excuse #318:

Your EMAIL is now being delivered by the USPS.
