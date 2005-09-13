Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVIMGrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVIMGrz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVIMGry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:47:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3530
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932406AbVIMGry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:47:54 -0400
Date: Mon, 12 Sep 2005 23:47:52 -0700 (PDT)
Message-Id: <20050912.234752.28084588.davem@davemloft.net>
To: kaos@sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <23056.1126592253@kao2.melbourne.sgi.com>
References: <20050912.223755.56102921.davem@davemloft.net>
	<23056.1126592253@kao2.melbourne.sgi.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Owens <kaos@sgi.com>
Date: Tue, 13 Sep 2005 16:17:33 +1000

> No, the 2.6.13 driver in 2.6.14-rc1 has exactly the same problem.
> 
> The last time that tg3 broke like this, it was because of the patch
> below, in 2.6.13-rc6.  That was backed out in 2.6.13-rc7.  Was the PCI
> patch (or equivalent) reinstated in 2.6.14-rc1?

It was reinstated, with a fix for the sparc64 problems it caused.
I wasn't aware of any ia64 regressions introduced by it.
