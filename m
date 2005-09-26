Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVIZV2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVIZV2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVIZV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:28:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:57836
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932323AbVIZV2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:28:32 -0400
Date: Mon, 26 Sep 2005 14:28:18 -0700 (PDT)
Message-Id: <20050926.142818.47709558.davem@davemloft.net>
To: akpm@osdl.org
Cc: alex.williamson@hp.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] sys_sendmsg() alignment bug fix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050926133634.657ef4a3.akpm@osdl.org>
References: <1127764921.6529.60.camel@tdi>
	<20050926133634.657ef4a3.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 26 Sep 2005 13:36:34 -0700

> OK, thanks - I'll send this on to davem.  It seems odd to be using
> __kernel_size_t rather than size_t, but that's what struct cmshdr does
> (also oddly).

Applied, thanks.
