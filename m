Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbVI3GZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVI3GZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVI3GZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 02:25:08 -0400
Received: from tachyon.quantumlinux.com ([64.113.1.99]:49309 "EHLO
	tachyon.quantumlinux.com") by vger.kernel.org with ESMTP
	id S932291AbVI3GZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 02:25:06 -0400
Date: Thu, 29 Sep 2005 23:25:14 -0700 (PDT)
From: Chuck Wolber <chuckw@quantumlinux.com>
X-X-Sender: chuckw@localhost.localdomain
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Mitsuru KANDA <mk@linux-ipv6.org>
Subject: Re: [PATCH 07/10] [PATCH] check connect(2) status for IPv6 UDP socket
In-Reply-To: <20050930022239.411732000@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0509292318320.29997@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
 <20050930022239.411732000@localhost.localdomain>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Chris Wright wrote:

> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> I think we should cache the per-socket route(dst_entry) only when the 
> IPv6 UDP socket is connect(2)'ed. (which is same as IPv4 UDP send 
> behavior)
> 
> Signed-off-by: Mitsuru KANDA <mk@linux-ipv6.org>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> ---

%< Snip %<


Does this really qualify as a necessary bug fix?

..Chuck..


-- 
http://www.quantumlinux.com
 Quantum Linux Laboratories, LLC.
 ACCELERATING Business with Open Technology

 "The measure of the restoration lies in the extent to which we apply
  social values more noble than mere monetary profit." - FDR
