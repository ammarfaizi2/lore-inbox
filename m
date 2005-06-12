Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVFLKco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVFLKco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVFLKco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:32:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17602 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261932AbVFLKci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:32:38 -0400
Date: Sun, 12 Jun 2005 12:32:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Willy Tarreau <willy@w.ods.org>
cc: subbie subbie <subbie_subbie@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time
In-Reply-To: <20050612102726.GA8470@alpha.home.local>
Message-ID: <Pine.LNX.4.61.0506121232080.18963@yvahk01.tjqt.qr>
References: <20050612071213.GG28759@alpha.home.local>
 <20050612101514.81433.qmail@web30707.mail.mud.yahoo.com>
 <20050612102726.GA8470@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>  - you don't know the root device, so the kernel will
>    panic at boot because it cannot find the root device.
>    In this case, you have the partition list still on
>    the screen as it's among the latest things in the
>    boot order. And if your kernel reboots upon panic,
>    just boot it with panic=30 so get 30 seconds to read
>    the partition table.

And, I might add, boot with vga=6 to get a *BIG* screen, so you won't miss any 
messages.



Jan Engelhardt                                                               
--                                                                            
| Gesellschaft fuer Wissenschaftliche Datenverarbeitung Goettingen,
| Am Fassberg, 37077 Goettingen, www.gwdg.de
