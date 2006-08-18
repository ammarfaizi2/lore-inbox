Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWHRGgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWHRGgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWHRGgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:36:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39127
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750706AbWHRGgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:36:33 -0400
Date: Thu, 17 Aug 2006 23:36:44 -0700 (PDT)
Message-Id: <20060817.233644.97293084.davem@davemloft.net>
To: shemminger@osdl.org
Cc: xavier.bestel@free.fr, 7eggert@gmx.de, cate@debian.org,
       7eggert@elstempel.de, mitch.a.williams@intel.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: restrict device names from having whitespace
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060817231127.6438324e@localhost.localdomain>
References: <20060818022057.GA27076@nostromo.devel.redhat.com>
	<44E68C4E.8070607@osdl.org>
	<20060817231127.6438324e@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Thu, 17 Aug 2006 23:11:27 -0700

> Don't allow spaces in network device names because it makes
> it difficult to provide text interfaces via sysfs.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

I have a patch which does this in my tree already Stephen.
