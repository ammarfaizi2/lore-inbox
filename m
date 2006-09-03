Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWICVz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWICVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWICVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 17:55:28 -0400
Received: from quechua.inka.de ([193.197.184.2]:7838 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750758AbWICVz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 17:55:27 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: in-kernel rpc.statd
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1GJzw4-0002ti-00@calista.eckenfels.net>
Date: Sun, 03 Sep 2006 23:55:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.61.0609032255010.6844@yvahk01.tjqt.qr> you wrote:
> Hm. I do not have a rpc.statd userspace program nor kernel daemon (running 
> on 2.6.17-vanilla). Yet everything is working. Is there a specific need for 
> statd?

It is more or less an uptime notification protocol for NFS locks. I think
NFS clients can recover from a reboot without the help of the statd in most
situations.

Gruss
Bernd

-- 
VGER BF report: H 0.429236
