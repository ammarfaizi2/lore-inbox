Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVCYWJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVCYWJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCYWI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:08:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:39595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261829AbVCYWGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:06:50 -0500
Date: Fri, 25 Mar 2005 14:06:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: <jason@stdbev.com>
Cc: linux-kernel@vger.kernel.org, Steven Cole <elenstev@mesatop.com>
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
Message-Id: <20050325140654.430714e2.akpm@osdl.org>
In-Reply-To: <761c884705af2ea412c083d849598ca7@stdbev.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
	<42446B86.7080403@mesatop.com>
	<424471CB.3060006@mesatop.com>
	<20050325122433.12469909.akpm@osdl.org>
	<4244812C.3070402@mesatop.com>
	<761c884705af2ea412c083d849598ca7@stdbev.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please dont' edit the cc line.  Just do reply-to-all)

"Jason Munro" <jason@stdbev.com> wrote:
>
> > [  146.301026] rock: directory entry would overflow storage
> > [  146.301044] rock: sig=0x5245, size=8, remaining=0
> > [  158.388397] rock: directory entry would overflow storage
> > [  158.388415] rock: sig=0x5850, size=36, remaining=34
> > [root@spc1 steven]#
> 
> 
> Same results with mm3 here, though mm2 will not boot on my machine so I'm
> not sure about that. 2.6.12-rc1 works fine, rc1-mm3 successfully mounts the
> cdrom device but shows no contents. Releveant dmsesg output:
> 
> rock: directory entry would overflow storage
> rock: sig=0x4543, size=28, remaining=0
> rock: directory entry would overflow storage

Seems that I am unable to read.  It's the new rock-ridge bounds checking.

It worked for me.  Is someone able to get an image of a failing filesystem
into my hands?

