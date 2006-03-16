Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752233AbWCPIMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbWCPIMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbWCPIMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:12:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29656
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751132AbWCPIMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:12:12 -0500
Date: Thu, 16 Mar 2006 00:11:50 -0800 (PST)
Message-Id: <20060316.001150.39950512.davem@davemloft.net>
To: eugene.teo@eugeneteo.net
Cc: linux-kernel@vger.kernel.org, thomas@x-berg.in-berlin.de,
       ralf@linux-mips.org, hans@esrac.ele.tue.nl
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in
 net/hamradio/6pack.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060316071028.GA22953@eugeneteo.net>
References: <20060316064637.GA22737@eugeneteo.net>
	<20060316071028.GA22953@eugeneteo.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Teo <eugene.teo@eugeneteo.net>
Date: Thu, 16 Mar 2006 15:10:28 +0800

> Pointer sp is dereferenced before NULL check.
> 
> Coverity bug #816
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

Also applied, thanks a lot.
