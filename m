Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVGDMIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVGDMIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVGDMIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:08:52 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:34710 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261642AbVGDMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:02:48 -0400
Date: Mon, 4 Jul 2005 14:02:34 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig changes 4: s/menu/menuconfig/ CPU scaling menu
In-Reply-To: <20050704115357.A587@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0507041334430.11818@be1.lrz>
References: <Pine.LNX.4.58.0506301152460.11960@be1.lrz>
 <Pine.LNX.4.58.0507041134410.3798@be1.lrz> <Pine.LNX.4.58.0507041210190.6165@be1.lrz>
 <Pine.LNX.4.58.0507041231200.6165@be1.lrz> <Pine.LNX.4.58.0507041243070.8687@be1.lrz>
 <20050704115357.A587@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2005, Russell King wrote:
> On Mon, Jul 04, 2005 at 12:43:56PM +0200, Bodo Eggert wrote:
> > Part 4: The CPU scaling menu.
> > 
> > In many config submenus, the first menu option will enable the rest 
> > of the menu options. For these menus, It's appropriate to use the more 
> > convenient "menuconfig" keyword.
> > 
> > This patch is designed for 2.6.13-rc1
> 
> This is inappropriate for ARM - take a look at the ARM Kconfig file
> around those lines which you deleted.  You'll notice that ARM contains
> some extra options for cpufreq which aren't offered on other
> architectures.
> 
> These options should appear under the cpufreq menu, and making this
> change means that they no longer do so.

My script missed some changes (Shouldn't be possible). I'll post the 
missing parts, which will restore the desired behaviour.

The update will change the main CPU scaling config to menuconfig,
and all other options will be added to the menu because they depend on 
that config.
-- 
Justify my text? I'm sorry but it has no excuse. 
