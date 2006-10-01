Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWJAKeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWJAKeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWJAKeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:34:44 -0400
Received: from colin.muc.de ([193.149.48.1]:17164 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932206AbWJAKen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:34:43 -0400
Date: 1 Oct 2006 12:34:42 +0200
Date: Sun, 1 Oct 2006 12:34:42 +0200
From: Andi Kleen <ak@muc.de>
To: "S.??a??lar Onur" <caglar@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: [Ops] 2.6.18
Message-ID: <20061001103442.GA94076@muc.de>
References: <200610010332.52509.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610010332.52509.caglar@pardus.org.tr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2006 at 03:32:49AM +0300, S.??a??lar Onur wrote:
> Hi;
> 
> Here [1] are the two different panics with 2.6.18 on vmware, its reproducable 
> on every 4-5 reboot [same config/kernel in "2.6.18 Nasty Lockup" thread, so i 
> CC'd to that thread's posters also]
> 
> [1] http://cekirdek.pardus.org.tr/~caglar/2.6.18/

The first thing when you get lots of weird oopses is to save your .config,
do a make distclean and try again. Sometimes kernels get miscompiled.

Also your oopses do not fit completely on the screen. Best you enable
CONFIG_VIDEO_SELECT and boot with vga=0x0f07
(if that doesn't work vga=ask and select the smallest resolution)

-Andi
