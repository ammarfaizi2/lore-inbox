Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWCPIMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWCPIMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbWCPIMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:12:15 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29912
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751132AbWCPIMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:12:15 -0500
Date: Thu, 16 Mar 2006 00:11:37 -0800 (PST)
Message-Id: <20060316.001137.59649354.davem@davemloft.net>
To: eugene.teo@eugeneteo.net
Cc: linux-kernel@vger.kernel.org, thomas@x-berg.in-berlin.de,
       ralf@linux-mips.org, hans@esrac.ele.tue.nl
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in
 net/hamradio/mkiss.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060316070737.GA22920@eugeneteo.net>
References: <20060316064211.GA22681@eugeneteo.net>
	<20060316070737.GA22920@eugeneteo.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Teo <eugene.teo@eugeneteo.net>
Date: Thu, 16 Mar 2006 15:07:37 +0800

> Pointer ax is dereferenced before NULL check.
> 
> Coverity bug #817
> 
> Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

Applied, thanks Eugene.
