Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423912AbWKAIeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423912AbWKAIeb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 03:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWKAIeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 03:34:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27595
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423685AbWKAIea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 03:34:30 -0500
Date: Wed, 01 Nov 2006 00:34:31 -0800 (PST)
Message-Id: <20061101.003431.129059138.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] dont insert sockets/pipes dentries into
 dentry_hashtable.
From: David Miller <davem@davemloft.net>
In-Reply-To: <454858F2.5020206@cosmosbay.com>
References: <200610311948.48970.dada1@cosmosbay.com>
	<20061031.231954.23010447.davem@davemloft.net>
	<454858F2.5020206@cosmosbay.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Wed, 01 Nov 2006 09:21:06 +0100

> No no, my patch takes care of that.
> 
> You still see the right link for pipes and sockets on /proc/$pid/fd/XXX
> 
> And " (deleted)" is correctly added to deleted files.

I see.  Excellent :-)
