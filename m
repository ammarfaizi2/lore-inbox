Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVGWAdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVGWAdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVGWAat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:30:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35287 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262254AbVGWA3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:29:22 -0400
Date: Sat, 23 Jul 2005 02:29:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: fix suspend/resume irq request free for yenta..
Message-ID: <20050723002924.GA1988@elf.ucw.cz>
References: <Pine.LNX.4.58.0507222331580.15287@skynet> <200507221816.19424.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507221816.19424.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Without this patch my laptop fails to resume from suspend to RAM...
> > 
> > It applies against a pretty recent 2.6.13-rc3 from git..
> > 
> 
> Hi,
> 
> Is it necessary to do free_irq for suspend? Shouldn't disable_irq
> be enough?

Due to recent changes in ACPI, yes, it is neccessary.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
