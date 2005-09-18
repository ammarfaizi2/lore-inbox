Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVIRGXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVIRGXN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVIRGXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:23:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7301
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751161AbVIRGXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:23:13 -0400
Date: Sat, 17 Sep 2005 23:23:04 -0700 (PDT)
Message-Id: <20050917.232304.31192760.davem@davemloft.net>
To: linville@tuxdriver.com
Cc: tony.luck@gmail.com, kaos@sgi.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050917155911.GB19854@tuxdriver.com>
References: <25288.1126596450@kao2.melbourne.sgi.com>
	<12c511ca05091708476aa136cd@mail.gmail.com>
	<20050917155911.GB19854@tuxdriver.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John W. Linville" <linville@tuxdriver.com>
Date: Sat, 17 Sep 2005 11:59:14 -0400

> I posted a patch on Wednesday:
> 
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html
> 
> The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
> patch to fix the problem.

It fixes the problem, but it's a hack, and I, perhaps like Tony,
personally would like to know why the these IA64 systems break for
such a simple operation such as writing some base registers with
values we've probed already.
