Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVH3Uaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVH3Uaf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVH3Uaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 16:30:35 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:34246 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932438AbVH3Uaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 16:30:35 -0400
Subject: Re: 2.6.13-rc7-rt4, fails to build
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125431276.25823.23.camel@cmn37.stanford.edu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu>
	 <20050829083541.GA21756@elte.hu>
	 <1125334627.7631.21.camel@cmn37.stanford.edu>
	 <20050830054852.GA5743@elte.hu>
	 <1125431276.25823.23.camel@cmn37.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 30 Aug 2005 21:59:26 +0100
Message-Id: <1125435566.8276.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Weird. These two lines in your patch (in ide-lib.c):
>         printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
>         printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
> have "dUmMy=" instead of "status=", a freshly unpacked
> linux-2.6.13.tar.bz2 tree has "status=" there, unless I'm making some
> stupid mistake (could be). 

That sounds like someone has a broken firewall filtering system.

