Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVLSWya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVLSWya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVLSWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 17:54:30 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44478
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965022AbVLSWy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 17:54:29 -0500
Date: Mon, 19 Dec 2005 14:52:54 -0800 (PST)
Message-Id: <20051219.145254.33863414.davem@davemloft.net>
To: bunk@stusta.de
Cc: gmack@innerfire.net, wli@holomorphy.com, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [2.6 patch] on sparc{,64}, RTC must depend on PCI
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051217141049.GP23349@stusta.de>
References: <20051216222154.GK23349@stusta.de>
	<Pine.LNX.4.64.0512161908460.20531@innerfire.net>
	<20051217141049.GP23349@stusta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Sat, 17 Dec 2005 15:10:49 +0100

> On sparc and sparc64, the rtc driver doesn't compile with PCI support 
> disabled.

Applied, thanks Adrian.

> BTW: @sparc maintainers:
>      Is there any reason against introducing a SPARC Kconfig symbol
>      that is set on both the sparc and sparc64 architectures?

That's a great idea, I thought we already did this in fact :)
