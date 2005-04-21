Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVDUHP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVDUHP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDUHP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:15:57 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:51129 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261362AbVDUHPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:15:35 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH 2.6.12-rc2] aoe [1/6]: improve allowed interfaces  configuration
To: Ed L Cashin <ecashin@coraid.com>, linux-kernel@vger.kernel.org,
       ecashin@coraid.com, Greg K-H <greg@kroah.com>
Reply-To: 7eggert@gmx.de
Date: Thu, 21 Apr 2005 09:14:46 +0200
References: <3VqSf-2z7-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DOVtj-0003bF-6c@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed L Cashin <ecashin@coraid.com> wrote:

> +++ b/Documentation/aoe/aoe.txt       2005-04-20 11:42:20.000000000 -0400

> +  When the aoe driver is a module, use

Is there any reason for this inconsistent behaviour?

> +  /sys/module/aoe/parameters/aoe_iflist instead of
                                ^^^

Why does the module name need to be part of the attribute?
That's redundant. That's redundant.

> +  There is a boot option for the built-in aoe driver and a
> +  corresponding module parameter, aoe_iflist.  Without this option,
> +  all network interfaces may be used for ATA over Ethernet.  Here is a
> +  usage example for the module parameter.
> +
> +    modprobe aoe_iflist="eth1 eth3"
               ^
             "aoe"
-- 
Top 100 things you don't want the sysadmin to say:
63. Oracle will be down until 8pm, but you can come back in and finish your
    work when it comes up tonight.

