Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbUK0Bvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbUK0Bvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbUK0BrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:07 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262369AbUKZTi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:28 -0500
Subject: Re: ide-cd problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Chandler <alan@chandlerfamily.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125152922.GC12098@suse.de>
References: <200411211613.54713.alan@chandlerfamily.org.uk>
	 <200411220752.28264.alan@chandlerfamily.org.uk>
	 <20041122080122.GM26240@suse.de>
	 <E1CWBSN-0003mF-4s@home.chandlerfamily.org.uk>
	 <20041122105157.GB10463@suse.de>
	 <E1CWCOC-0003so-Ao@home.chandlerfamily.org.uk>
	 <20041122113150.GF10463@suse.de>
	 <E1CWDhN-00040Y-E6@home.chandlerfamily.org.uk>
	 <20041122130202.GO10463@suse.de>
	 <1101338347.2571.8.camel@localhost.localdomain>
	 <20041125152922.GC12098@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101399946.18177.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 16:25:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-25 at 15:29, Jens Axboe wrote:
> Something is funky with this drive, it requires an extra delay after it
> has raised an interrupt. But we can restrict it to ide-cd once it's
> fully understood.

You are assuming its a drive issue. Some controllers have errata around
this area that might be involved too. We can certainly stick a quirk for
IRQ delay into the drive tho

