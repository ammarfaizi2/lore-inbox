Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTE0LEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTE0LEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:04:04 -0400
Received: from guri.is.kpn.be ([193.74.71.22]:30115 "EHLO guri.is.kpn.be")
	by vger.kernel.org with ESMTP id S263239AbTE0LED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:04:03 -0400
Date: Tue, 27 May 2003 13:19:23 +0200
To: linux-kernel@vger.kernel.org
Subject: should-fix(?) list
Message-ID: <20030527111923.GA386@gouv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Leopold Gouverneur <lgouv@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least for me! in 2.5.70:

1) drivers/char/ftape don't compile( it uses deprecated sti, save_flags
etc ...)
I tried to "fix" it by applying a patch posted some time ago on this
list. It compiled wonderfully but trashed my hard diks even more
wonderfully :(

2)net/core/dev.c spits tons of "fix old protocol handler
pppoe_rcv+0x0/0x150!" to my console to the point of slowing down my adsl
connection by 50%. I "fixed" it by commenting out print_symbol line.Not
very clever but got my old connection speed back whithout any apparent 
ill effect, so ...

3) drivers/ide/pci/hpt336 slows down the disk on it from 35MB/sec in 2.4 
to 24MB/sec. I presume it's the specific driver because for my other
devices on piix the performance is exactly the same in 2.4 and 2.5.

Thanks for listening!


