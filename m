Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbVKHQxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbVKHQxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVKHQxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:53:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2724
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965136AbVKHQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:53:46 -0500
Date: Tue, 08 Nov 2005 08:51:48 -0800 (PST)
Message-Id: <20051108.085148.117005590.davem@davemloft.net>
To: akpm@osdl.org
Cc: hch@lst.de, linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: [PATCH] use ptrace_get_task_struct in various places
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051107221149.08aa0820.akpm@osdl.org>
References: <20051108053049.GA9422@lst.de>
	<20051107221149.08aa0820.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 7 Nov 2005 22:11:49 -0800

> The change breaks ALLOW_INIT_TRACING in sparc32 and sparc64.  I don't know
> if that matters.  If (presumably) not, there are cleanups left over.

You can kill that ALLOW_INIT_TRACING crap.
