Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVCPXYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVCPXYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 18:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVCPXXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 18:23:20 -0500
Received: from zork.zork.net ([64.81.246.102]:16788 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262856AbVCPXW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:22:28 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
References: <20050316040654.62881834.akpm@osdl.org>
	<6u8y4n434b.fsf@zork.zork.net> <20050316150612.2359a488.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Date: Wed, 16 Mar 2005 23:22:27 +0000
In-Reply-To: <20050316150612.2359a488.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 16 Mar 2005 15:06:12 -0800")
Message-ID: <6u4qfb41n0.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Yes, the pmac cpufreq Kconfig dependencies are being troublesome.
>
> Roman sent this to Ben and I overnight:
>
>
> From: Roman Zippel <zippel@linux-m68k.org>
>
> This completes the Kconfig cleanup for all other archs.  CPU_FREQ_TABLE was
> moved to drivers/cpufreq/Kconfig and is selected as needed.

Seems to do the trick on ppc: with this patch applied, oldconfig
results in CONFIG_CPU_FREQ_TABLE=y.

-- 
Dag vijandelijk luchtschip de huismeester is dood
