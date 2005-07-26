Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVGZXdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVGZXdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGZXc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:32:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12519
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262352AbVGZXbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:31:47 -0400
Date: Tue, 26 Jul 2005 16:32:02 -0700 (PDT)
Message-Id: <20050726.163202.119887768.davem@davemloft.net>
To: mpm@selenic.com
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050726232043.GB7425@waste.org>
References: <20050719182919.GA5531@stusta.de>
	<20050719.140104.68160812.davem@davemloft.net>
	<20050726232043.GB7425@waste.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Tue, 26 Jul 2005 16:20:43 -0700

> This problem also exists in PKTGEN. And this fix is incorrect as
> neither is dependent on the IP part of the networking stack in any
> substantive way. The right fix is to make inet_aton available outside
> of CONFIG_INET (preferred) or making private copies of inet_aton.

Adrian posted a fix, you whine, that's why Adrian's fix
went in :-)

More seriously, please submit a version of whatever you
believe to be the more correct fix so it can be reviewed
and integrated.
