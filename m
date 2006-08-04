Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWHDABm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWHDABm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWHDABm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:01:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52883
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030239AbWHDABl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:01:41 -0400
Date: Thu, 03 Aug 2006 17:01:43 -0700 (PDT)
Message-Id: <20060803.170143.20633018.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: tytso@mit.edu, mchan@broadcom.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060803235927.GB10932@gondor.apana.org.au>
References: <20060803235326.GC7894@thunk.org>
	<20060803.165654.45876296.davem@davemloft.net>
	<20060803235927.GB10932@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 4 Aug 2006 09:59:27 +1000

> Watchdogs usually require one heartbeat every 30 seconds or so.  Does
> the ASF heartbeat need to be that frequent?

The ASF heartbeat needs to be sent every 2 seconds.
