Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbRBSJaf>; Mon, 19 Feb 2001 04:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129358AbRBSJaZ>; Mon, 19 Feb 2001 04:30:25 -0500
Received: from quechua.inka.de ([212.227.14.2]:15396 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129177AbRBSJaL>;
	Mon, 19 Feb 2001 04:30:11 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack error under 2.4.1-ac18
In-Reply-To: <14992.40178.870916.407096@rhino.thrillseeker.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14Ume3-0000Lq-00@sites.inka.de>
Date: Mon, 19 Feb 2001 10:30:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14992.40178.870916.407096@rhino.thrillseeker.net> you wrote:
> Feb 18 23:05:50 rhino kernel: ip_conntrack: maximum limit of 8184 entries exceed
> ed

> while running nessus, with 100 simultaneous connections set, against a
> company machine.  This is the first time I've observed this error.

It is not an error, you just used up all entries in the Conenction Track
Table. You can increase the number of entries or reduce the number of
concurrent Connections. You may also be able to use normal connect() scan
methods, AFAIK the timing out of the connections is better with this.

Greetings
Bernd
