Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVG0VOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVG0VOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVG0VN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:13:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43420
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262344AbVG0VNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:13:50 -0400
Date: Wed, 27 Jul 2005 14:13:41 -0700 (PDT)
Message-Id: <20050727.141341.21926817.davem@davemloft.net>
To: mpm@selenic.com
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050727204622.GI12006@waste.org>
References: <20050727023636.GP12006@waste.org>
	<20050727.131900.59654701.davem@davemloft.net>
	<20050727204622.GI12006@waste.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Wed, 27 Jul 2005 13:46:22 -0700

> Odd, gitweb of Linus' tree seems to disagree. I see it depends on
> NETDEVICES && INET && EXPERIMENTAL. NETDEVICES has been there since
> the beginning of git history and according to my Mercurial import from
> BKCVS, it's been dependent on NETDEVICES since I first submitted it.

Sorry, that's a result of a local change I just added
to fix up presentation the net device family Kconfig's.
