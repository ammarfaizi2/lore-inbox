Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbUKCWfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUKCWfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUKCWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:24:10 -0500
Received: from quechua.inka.de ([193.197.184.2]:24019 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261936AbUKCWGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:06:04 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ipv4 arp and linux
Organization: Deban GNU/Linux Homesite
In-Reply-To: <UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAAYtAmuHujdUS5GzoYL+cKTQEAAAAA@getonit.net.au>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CPTGR-0001Ms-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 03 Nov 2004 23:05:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAAYtAmuHujdUS5GzoYL+cKTQEAAAAA@getonit.net.au> you wrote:
> Those aren't 64 bytes, but would tcpdump show the padding?

# tcpdump -v -v -i eth0 -s1500 -X -X arp
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 1500 bytes
23:04:28.977213 arp who-has 10.0.0.2 tell darkover.inka.de
        0x0000:  ffff ffff ffff 00e0 4c39 12b5 0806 0001  ........L9......
        0x0010:  0800 0604 0001 00e0 4c39 12b5 0a00 0004  ........L9......
        0x0020:  0000 0000 0000 0a00 0002 0000 0000 0000  ................
        0x0030:  0000 0000 0000 0000 0000 0000            ............


You should not forget the LL headers.

Greetings
Bernd
