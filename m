Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVCKMaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVCKMaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVCKM2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:28:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:7389 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262702AbVCKM2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:28:11 -0500
Subject: Re: [announce 7/7] fbsplash - documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Januszewski <spock@gentoo.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <200503090117.12755.arnd@arndb.de>
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de> <20050308223728.GA11065@spock.one.pl>
	 <200503090117.12755.arnd@arndb.de>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 23:27:47 +1100
Message-Id: <1110544067.5810.100.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I don't understand. Does the kernel code need to wait for the helper
> to finish while holding the semaphore? AFAICS, the helper is completely
> asynchronous, so it can simply do its job when the kernel has given
> up the semaphore.

It should be totally async witout any sem. there is no guarantee that
userspace is even available at the time you do the call.



