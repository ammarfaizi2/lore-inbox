Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753902AbWKFWvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbWKFWvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbWKFWvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:51:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21444
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753902AbWKFWvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:51:52 -0500
Date: Mon, 06 Nov 2006 14:51:54 -0800 (PST)
Message-Id: <20061106.145154.63997990.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, acme@mandriva.com
Subject: Re: + net-uninline-xfrm_selector_match.patch added to -mm tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061106144932.8c63a6ed.akpm@osdl.org>
References: <200611031934.kA3JYCjF030732@shell0.pdx.osdl.net>
	<20061106.143831.88477819.davem@davemloft.net>
	<20061106144932.8c63a6ed.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Mon, 6 Nov 2006 14:49:32 -0800

> I would have found that out when I got around to compiling it ;)
> 
> Where should the out-of-line function be placed, or should I just drop it? 

Either xfrm_policy.c or xfrm_state.c would work fine.
