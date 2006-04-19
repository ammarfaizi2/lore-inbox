Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWDSACQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWDSACQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWDSACP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:02:15 -0400
Received: from bne.snapgear.com ([203.143.235.140]:34825 "EHLO
	cyberguard.com.au") by vger.kernel.org with ESMTP id S1750861AbWDSACL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:02:11 -0400
Message-ID: <44457E00.1030504@snapgear.com>
Date: Wed, 19 Apr 2006 10:02:08 +1000
From: Philip Craig <philipc@snapgear.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: bunk@stusta.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] net/netlink/: possible cleanups
References: <20060413162710.GE4162@stusta.de> <20060413.132603.94193712.davem@davemloft.net>
In-Reply-To: <20060413.132603.94193712.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2006 06:26 AM, David S. Miller wrote:
> These interfaces were added so that new users of netlink could
> write their code more easily.
>
> Unused does not equate to "comment out or delete".

Does a GENETLINK Kconfig option make sense (possibly dependant on
EMBEDDED)?  I'm unsure whether these interfaces are going to be used
in core networking code that can't be disabled anyway.
