Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbVHZXPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbVHZXPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbVHZXPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 19:15:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59534
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751505AbVHZXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 19:15:40 -0400
Date: Fri, 26 Aug 2005 16:15:37 -0700 (PDT)
Message-Id: <20050826.161537.03992270.davem@davemloft.net>
To: adobriyan@gmail.com
Cc: rml@novell.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050826225848.GC28191@mipter.zuzino.mipt.ru>
References: <1125094725.18155.120.camel@betsy>
	<20050826225848.GC28191@mipter.zuzino.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sat, 27 Aug 2005 02:58:48 +0400

> What's the point of having unlikely() attached to every possible if ()?

If can result in smaller code, for one thing, even if it
isn't a performance critical path.
