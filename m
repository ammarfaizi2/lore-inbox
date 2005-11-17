Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbVKQXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbVKQXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbVKQXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:47:59 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62144
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965136AbVKQXr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:47:58 -0500
Date: Thu, 17 Nov 2005 15:46:48 -0800 (PST)
Message-Id: <20051117.154648.66150660.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, paulus@samba.org,
       benh@kernel.crashing.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] unpaged: VM_UNPAGED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171932440.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171932440.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:34:55 +0000 (GMT)

> Use the VM_SHM slot for VM_UNPAGED, and define VM_SHM to 0: it serves no
> purpose whatsoever, and should be removed from drivers when we clean up.

VM_SHM does absolutely nothing in 2.4.x as well, I'd recommend
killing it off now.
