Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUAEMmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbUAEMmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:42:16 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:35475 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S264331AbUAEMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:42:11 -0500
Date: Mon, 5 Jan 2004 13:36:51 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: Hisax(Netjet) dysfunctional in 2.6.0
Message-ID: <Pine.LNX.4.30.0401051322410.5246-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it looks like ISDN4L with the hisax driver does not work anymore
in kernel 2.6.0. On my machine, the driver gets loaded, prints a
couple of messages to the syslog (none of them look like errors)
and then unloads again without any apparent reason:

...: ISDN subsystem initialized
...: HiSax: Linux Driver for passive ISDN cards
...: HiSax: Version 3.5 (module)
     ...
...: HiSax: Total 1 card defined
...: get_drv 0: 0 -> 1
...: teles0: State ST_DRV_NULL Event EV_DRV_REGISTER
...: teles0: ChangeState ST_DRV_LOADED
...: HiSax: Card 1 Protocol EDSS1 Id=teles0 (0)
...: HiSax: Traverse Tech. NETjet-S driver Rev. 2.7.6.6
...: PCI: Found IRQ 10 for device 0000:02:0c.0
...: PCI: Sharing IRQ 10 with 0000:02:05.0
...: NETjet-S: PCI card configured at 0xa800 IRQ 10
...: HiSax: ISAC version (0): 2086/2186 V1.1
...: get_drv 0: 1 -> 2
...: teles0: State ST_DRV_LOADED Event EV_STAT_UNLOAD
...: put_drv 0: 2 -> 1
...: put_drv 0: 1 -> 0
...: HiSax: Card type 20 not installed !

With kernel 2.4.x everything works without any problems.

Any Ideas?
Regards,
                    Peter Daum

