Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbVJ1VVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbVJ1VVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbVJ1VVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:21:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:18845 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751810AbVJ1VVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:21:50 -0400
From: Andi Kleen <ak@suse.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Date: Fri, 28 Oct 2005 23:22:15 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <200510271026.10913.ak@suse.de> <20051028205132.GB11397@elf.ucw.cz> <20051028205916.GL4464@flint.arm.linux.org.uk>
In-Reply-To: <20051028205916.GL4464@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510282322.16627.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 22:59, Russell King wrote:
> On Fri, Oct 28, 2005 at 10:51:32PM +0200, Pavel Machek wrote:
> > Well, keyboard detected and reported an error. Kernel reacted with
> > printk(). You are removing that printk(). I can understand that,
> > printk is really annoying, but I really believe _some_ error handling
> > should be added there if you remove the printk.
> 
> What do you suggest?

Obviously it needs an DBUS over netlink interface with an user space daemon to open 
a window on the desktop. Then the user needs to click ok to make sure they 
understood they did something wrong (either by buying broken hardware or by simply 
typing).

You get bonus points when that window first opens another window with a "Did you 
know ..." message with a little dancing pink penguin that gives you helpful tips 
regarding typing on keyboards and offers you links to buy new keyboards on the web.

Wouldn't that be great?

-Andi
