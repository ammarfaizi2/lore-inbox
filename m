Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758358AbWK0R2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbWK0R2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758462AbWK0R2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:28:23 -0500
Received: from lmailproxy02.edpnet.net ([212.71.1.195]:61135 "EHLO
	lmailproxy02.edpnet.net") by vger.kernel.org with ESMTP
	id S1758357AbWK0R2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:28:22 -0500
Date: Mon, 27 Nov 2006 18:28:17 +0100
From: Laurent Bigonville <l.bigonville@edpnet.be>
To: linux-kernel@vger.kernel.org
Subject: O2micro smartcard reader driver.
Message-Id: <20061127182817.d52dfdf1.l.bigonville@edpnet.be>
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a thread (about one month old) about an OZ711Mx (O2micro mmc
card reader) driver, but unfortunately it uses some closed-source
code.[1] :(

But I found no thread about the kernel driver for the O2micro PCMCIA
smartcard reader. So I would like to know if there is any chance that
this driver may be included in the mainline kernel.
The source are LGPL'ed and available via the musclecard website[2]. And
I found a patch to make it compile with kernel > 2.6.13 on the ubuntu
support site[3]. AFAIK the module work, the only issue I have is a
small hang when inserting a card in the reader.

If some one could have a look at this.

Regards

Laurent Bigonville

[1] http://lkml.org/lkml/2006/10/27/57
[2]
ftp://scrdriver:scrdriver@209.19.104.194/Linux/O2Micro_PCMCIA_SCR_203_Linux_Kernel26_OpenSource.tar.gz
[3] https://answers.launchpad.net/distros/ubuntu/+ticket/2535
