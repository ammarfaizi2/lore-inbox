Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWDRSlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDRSlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 14:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWDRSlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 14:41:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34023 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932158AbWDRSlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 14:41:02 -0400
Subject: Re: [RFC: 2.6 patch] net/netlink/: possible cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060418141946.GC11582@stusta.de>
References: <20060413162710.GE4162@stusta.de>
	 <20060413.132603.94193712.davem@davemloft.net>
	 <20060414103202.GF4162@stusta.de> <20060414105610.GA18149@2ka.mipt.ru>
	 <20060418141946.GC11582@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 19:48:41 +0100
Message-Id: <1145386121.21723.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 16:19 +0200, Adrian Bunk wrote:
> OTOH, we also have to always check whether users are expected soon (and 
> recheck whether there are really users after some time) since every 
> single export makes the kernel larger for nearly everyone.

Of course fixing the amount of memory used by an EXPORT_SYMBOL would be
far more productive.

