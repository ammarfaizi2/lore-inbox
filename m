Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGaDOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGaDOI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGaDOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:14:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58327 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261576AbVGaDOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:14:06 -0400
Message-ID: <42EC41ED.3010000@pobox.com>
Date: Sat, 30 Jul 2005 23:13:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jouni Malinen <jkmaline@cc.hut.fi>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] include/net/ieee80211.h must #include <linux/wireless.h>
References: <20050727195100.GA29092@stusta.de> <20050731022422.GH8195@jm.kir.nu>
In-Reply-To: <20050731022422.GH8195@jm.kir.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jouni Malinen wrote:
> Wouldn't the proper fix be to just remove this backwards compatibility
> code since WIRELESS_EXT is actually 18 in this tree anyway.. Is there
> valid need to keep this header file compatible with older kernel
> versions?

Nope.  Ripping out such back-compat code would be quite acceptable.

	Jeff


