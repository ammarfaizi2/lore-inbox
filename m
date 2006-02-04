Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWBDXut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWBDXut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbWBDXut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:50:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4264
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964884AbWBDXus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:50:48 -0500
Date: Sat, 04 Feb 2006 15:50:42 -0800 (PST)
Message-Id: <20060204.155042.92905949.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: mk@linux-ipv6.org, linux-kernel@vger.kernel.org, pekkas@netcore.fi,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
Subject: Re: [PATCH][ipcomp6] don't check vfree() argument for NULL.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200602042049.44151.jesper.juhl@gmail.com>
References: <200602042049.44151.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Sat, 4 Feb 2006 20:49:44 +0100

> vfree does it's own NULL checking, so checking a pointer before handing
> it to vfree is pointless.
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Applied to net-2.6.17, thanks.
