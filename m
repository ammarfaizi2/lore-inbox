Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUE1Unj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUE1Unj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUE1Unj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 16:43:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:4764 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261604AbUE1Unh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 16:43:37 -0400
Date: Fri, 28 May 2004 13:20:54 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-mm1: revert leave-runtime-suspended-devices-off-at-system-resume.patch
Message-ID: <20040528202054.GA9803@kroah.com>
References: <1085658551.1998.7.camel@teapot.felipe-alfaro.com> <20040527233432.GE7176@slurryseal.ddns.mvista.com> <1085742197.1684.0.camel@teapot.felipe-alfaro.com> <20040528185459.GG7176@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528185459.GG7176@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 11:54:59AM -0700, Todd Poynor wrote:
> A patch to fix my previous
> leave-runtime-suspended-devices-off-at-system-resume patch; the new
> changes save a copy of power.power_state in order to know whether to
> resume a device, independently of mods to that field by a driver suspend
> routine.  This fixes 2.6.7-rc1-mm1 in the same fashion as the updated
> 2.6.6 patch sent previously.  Thanks -- Todd

Applied to my trees, thanks.

greg k-h
