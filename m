Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbUE1VSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUE1VSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUE1VSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:18:06 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:59396 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261672AbUE1VSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:18:04 -0400
Subject: Re: 2.6.7-rc1-mm1: revert
	leave-runtime-suspended-devices-off-at-system-resume.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Todd Poynor <tpoynor@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040528185459.GG7176@slurryseal.ddns.mvista.com>
References: <1085658551.1998.7.camel@teapot.felipe-alfaro.com>
	 <20040527233432.GE7176@slurryseal.ddns.mvista.com>
	 <1085742197.1684.0.camel@teapot.felipe-alfaro.com>
	 <20040528185459.GG7176@slurryseal.ddns.mvista.com>
Content-Type: text/plain
Message-Id: <1085779067.1952.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 28 May 2004 23:17:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-28 at 20:54, Todd Poynor wrote:
> A patch to fix my previous
> leave-runtime-suspended-devices-off-at-system-resume patch; the new
> changes save a copy of power.power_state in order to know whether to
> resume a device, independently of mods to that field by a driver suspend
> routine.  This fixes 2.6.7-rc1-mm1 in the same fashion as the updated
> 2.6.6 patch sent previously.  Thanks -- Todd

This one works flawlessly.
Thanks!

