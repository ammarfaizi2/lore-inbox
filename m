Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDEH51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDEH51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWDEH51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:57:27 -0400
Received: from [194.90.237.34] ([194.90.237.34]:39764 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1751155AbWDEH51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:57:27 -0400
Date: Wed, 5 Apr 2006 10:58:39 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: "David S. Miller" <davem@davemloft.net>
Cc: rdreier@cisco.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, openib-general@openib.org, bunk@stusta.de,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
Message-ID: <20060405075839.GD14808@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <adar74cnajg.fsf@cisco.com> <20060404.171739.92845421.davem@davemloft.net> <adamzf0n98z.fsf@cisco.com> <20060404.174741.63557413.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.174741.63557413.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 05 Apr 2006 08:00:12.0156 (UTC) FILETIME=[F71FDBC0:01C65886]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David S. Miller <davem@davemloft.net>:
> I think it's too risky.  It fixes a panic for infiniband.

Fair enough.

> I think you should not have submitted such a core networking change to
> -stable without passing it by netdev CC:'ing me first.

OK, note taken.

-- 
Michael S. Tsirkin
