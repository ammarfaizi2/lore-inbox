Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWDSElZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWDSElZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 00:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWDSElZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 00:41:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62642
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750814AbWDSElY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 00:41:24 -0400
Date: Tue, 18 Apr 2006 21:41:21 -0700 (PDT)
Message-Id: <20060418.214121.80350811.davem@davemloft.net>
To: patrakov@ums.usu.ru
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.16.7
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4445BB0F.6010305@ums.usu.ru>
References: <44448DFF.3080108@ums.usu.ru>
	<20060418153951.GC30485@kroah.com>
	<4445BB0F.6010305@ums.usu.ru>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Date: Wed, 19 Apr 2006 10:22:39 +0600

> Without that patch, there is a race when registering network interfaces 
> and renaming it with udev rules, because initially the "address" in 
> sysfs doesn't contain useful data. See 
> http://marc.theaimsgroup.com/?t=114460338900002&r=1&w=2
> 
> Breaking the recommended way of assigning persistent network interface 
> names is, IMHO, a bug serious enough to be fixed in -stable.
> 
> Signed-off-by: Alexander E. Patrakov <patrakov@ums.usu.ru>

I've been waiting to see if there is any negative fallout
from this change, but I guess it's OK for stable.
