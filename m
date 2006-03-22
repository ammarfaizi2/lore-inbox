Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWCVDUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWCVDUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCVDUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:20:08 -0500
Received: from fmr20.intel.com ([134.134.136.19]:10884 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750702AbWCVDUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:20:06 -0500
Subject: Re: [PATCH 2.6.16-rc6 1/1] ipw2200: Add Kconfig entries for QOS
	and Monitor mode
From: Zhu Yi <yi.zhu@intel.com>
To: Andreas Happe <andreashappe@snikt.net>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@vger.kernel.org
In-Reply-To: <20060318174703.GA22072@localdomain>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	 <20060303152641.GR9295@stusta.de>
	 <200603050146.27529.andreashappe@snikt.net>
	 <20060307170642.GE3974@stusta.de> <20060303045651.1f3b55ec.akpm@osdl.org>
	 <20060303152641.GR9295@stusta.de>
	 <200603050146.27529.andreashappe@snikt.net>
	 <20060317191447.GC21830@tuxdriver.com> <20060318174703.GA22072@localdomain>
Content-Type: text/plain
Organization: Intel Corp.
Date: Wed, 22 Mar 2006 11:11:37 +0800
Message-Id: <1142997102.17270.131.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 18:47 +0100, Andreas Happe wrote:
> Adds Kconfig entries for enabling Monitor mode and Quality of service
> to the ipw2200 driver. It also renames the IPW_QOS define to
> IPW2200_QOS.
> 
> As Monitor mode generates lots of firmware errors it depends upon
> BROKEN. QOS is under development, so it depends upon EXPERIMENTAL.

Ack the rename and QoS description changes.

The IPW2200_MONITOR and monitor mode firmware error are already fixed in
wireless-2.6 GIT
http://kernel.org/git/?p=linux/kernel/git/linville/wireless-2.6.git;a=summary

Wireless related development happens there. I'd suggest you create
patches against that tree.

Thanks,
-yi

