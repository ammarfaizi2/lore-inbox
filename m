Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVH3OHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVH3OHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVH3OHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:07:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40090 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932122AbVH3OHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:07:53 -0400
Subject: Re: KLive: Linux Kernel Live Usage Monitor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 15:36:50 +0100
Message-Id: <1125412611.8276.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-30 at 10:01 +0200, Sven Ladegast wrote:
> The idea isn't bad but lots of people could think that this is some kind 
> of home-phoning or spy software. I guess lots of people would turn this 
> feature off...and of course you can't enable it by default. But combined 
> with an automatic oops/panic/bug-report this would be _very_ useful I think.

Wrong way around - you need to let people turn it on. Perhaps distribute
it with the kernel so you can 

		make register
		[Reports hardware, stashed a unique sha-1 hashed cookie]
		[Asks for permission, installs UDP ping daemon]
		

		make unregister


but it would have to be opt in. That might lower coverage but should
increase quality, especially id the id in the cookie can be put into
bugzilla reports, and the hardware reporting is done so it can be
machine processed (ie so you can ask stuff like 'reliability with Nvidia
IDE')

Alan

