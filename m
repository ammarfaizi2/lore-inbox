Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbWDEBIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbWDEBIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWDEBIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:08:44 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:63330 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750924AbWDEBIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:08:43 -0400
X-IronPort-AV: i="4.04,88,1144047600"; 
   d="scan'208"; a="422116520:sNHT33221934"
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       openib-general@openib.org, bunk@stusta.de, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, rdunlap@xenotime.net,
       davej@redhat.com, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il,
       rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
X-Message-Flag: Warning: May contain useful information
References: <adar74cnajg.fsf@cisco.com>
	<20060404.171739.92845421.davem@davemloft.net>
	<adamzf0n98z.fsf@cisco.com>
	<20060404.174741.63557413.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 04 Apr 2006 18:08:34 -0700
In-Reply-To: <20060404.174741.63557413.davem@davemloft.net> (David S. Miller's message of "Tue, 04 Apr 2006 17:47:41 -0700 (PDT)")
Message-ID: <adaek0cn819.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Apr 2006 01:08:35.0899 (UTC) FILETIME=[770218B0:01C6584D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I think it's too risky.  It fixes a panic for infiniband.

Fair enough.

    David> I think you should not have submitted such a core
    David> networking change to -stable without passing it by netdev
    David> CC:'ing me first.

Noted.  Glad I wasn't the one who submitted it ;)

 - R.
