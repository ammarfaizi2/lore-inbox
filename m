Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWENUmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWENUmq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 16:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWENUmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 16:42:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4325
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750723AbWENUmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 16:42:46 -0400
Date: Sun, 14 May 2006 13:42:31 -0700 (PDT)
Message-Id: <20060514.134231.101346572.davem@davemloft.net>
To: akpm@osdl.org
Cc: ranjitm@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] tcpdump may trace some outbound packets twice.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060514031034.5d0396e7.akpm@osdl.org>
References: <Pine.LNX.4.56.0605101315380.8735@ranjit.corp.google.com>
	<20060514031034.5d0396e7.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 14 May 2006 03:10:34 -0700

> It's a bit sad to be taking a clone of a clone like this.
> Avoidable?

Besides, clones of clones are illegal, if it's already a clone
you must make a copy.
