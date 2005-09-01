Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVIAWKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVIAWKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVIAWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:10:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19410
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030444AbVIAWKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:10:44 -0400
Date: Thu, 01 Sep 2005 15:10:50 -0700 (PDT)
Message-Id: <20050901.151050.132445173.davem@davemloft.net>
To: geoffrey.levand@am.sony.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix minor bug in sungem.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <430D0F6F.1030903@am.sony.com>
References: <430D0F6F.1030903@am.sony.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>
Date: Wed, 24 Aug 2005 17:23:11 -0700

> This changes the Sun Gem Ether driver's tx ring buffer 
> length to the proper constant.  Currently TX_RING_SIZE 
> and RX_RING_SIZE are equal, so no malfunction occurs.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Applied, thanks for catching this Geoff.
