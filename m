Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265462AbUGVN3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbUGVN3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 09:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUGVN3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 09:29:43 -0400
Received: from mrsmall.designassembly.de ([217.11.62.35]:52664 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S265462AbUGVN3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 09:29:43 -0400
Message-ID: <40FFC13A.9020201@designassembly.de>
Date: Thu, 22 Jul 2004 15:29:30 +0200
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040702)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: CONFIG_NET_RADIO vs CONFIG_NET_WIRELESS
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am confused. CONFIG_NET_RADIO is set when you select "Wireless LAN 
drivers". But building of drivers/net/wireless depends on 
CONFIG_NET_WIRELESS, but not a single Kconfig defines this value (it is 
defined in some defconfigs though). So the wireless LAN drivers are 
never built.

What am I missing???

Michael
