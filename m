Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUKQQca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUKQQca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbUKQQb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:31:57 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:58852 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262372AbUKQQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:29:23 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: john stultz <johnstul@us.ibm.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1100592718.2811.8.camel@laptop.fenrus.org>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
	 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
	 <1100592718.2811.8.camel@laptop.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100705157.32698.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:25:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 08:11, Arjan van de Ven wrote:
> > While there are a great number of systems that can use the TSC, cpufreq
> > scaling laptops, and a number of SMP and NUMA systems cannot use it as a
> > time source. 
> 
> please don't drag cpufreq into this; cpufreq adjusts this timer on
> frequency changes just fine.

Not on multiprocessor systems

