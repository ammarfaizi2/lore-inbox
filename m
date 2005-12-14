Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVLNXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVLNXtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVLNXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:49:04 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:31876
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965119AbVLNXtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:49:01 -0500
Date: Wed, 14 Dec 2005 15:48:07 -0800 (PST)
Message-Id: <20051214.154807.46858829.davem@davemloft.net>
To: torvalds@osdl.org
Cc: bunk@stusta.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
References: <20051214140531.7614152d.akpm@osdl.org>
	<20051214221304.GE23349@stusta.de>
	<Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Wed, 14 Dec 2005 14:36:59 -0800 (PST)

> It also refuses to turn on for SPARC64, since that seems to be known 
> broken. Or should it be just "SPARC"? Davem?

Refuse it just for SPARC64.

I intend to track down what the problem is eventually.
But for now, allowing folks to enable it is only
resulting in tons of duplicate bug reports.
