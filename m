Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWH2JQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWH2JQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWH2JQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:16:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48329
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932226AbWH2JQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:16:13 -0400
Date: Tue, 29 Aug 2006 02:15:46 -0700 (PDT)
Message-Id: <20060829.021546.85419569.davem@davemloft.net>
To: mita@miraclelinux.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kaber@trash.net,
       akpm@osdl.org
Subject: Re: call panic if nl_table allocation fails
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060823113740.GA7834@miraclelinux.com>
References: <20060823113740.GA7834@miraclelinux.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <mita@miraclelinux.com>
Date: Wed, 23 Aug 2006 20:37:40 +0900

> This patch makes crash happen if initialization of nl_table fails
> in initcalls. It is better than getting use after free crash later.
> 
> Cc: Patrick McHardy <kaber@trash.net>
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Patch applied, thank you.
