Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUDFHuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 03:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbUDFHuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 03:50:21 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46993 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263655AbUDFHuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 03:50:20 -0400
Date: Tue, 6 Apr 2004 09:47:07 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: =?unknown-8bit?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osd.org>, Manfred Spraul <manfred@colorfullife.com>,
       netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040406094707.A29666@electric-eye.fr.zoreil.com>
References: <200404060108.19488.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200404060108.19488.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on Tue, Apr 06, 2004 at 01:08:19AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel <Dieter.Nuetzel@hamburg.de> :
[...]
> Isn't the "current" RTL8169s (32/64) driver much outdated?
> 
> I got a version # 1.6 with all my cards.

This version has been merged in -mm since late 2003. Complete history is
available on the netdev mailing list.

>From memory, there should be a Tx descriptor overflow bug in # 1.6 (see
tx_interrupt). You may want to change some bits in your #1.6 version.

There is a regression related to link removal in the current -mm/jg-netdev
version (-mm stands behind jg-netdev where I hope to push what is posted
on the netdev mailing list). Stay tuned. :o)

--
Ueimor
