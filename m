Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbRENCyR>; Sun, 13 May 2001 22:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbRENCyG>; Sun, 13 May 2001 22:54:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38576 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262184AbRENCyD>;
	Sun, 13 May 2001 22:54:03 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15103.18624.98009.842915@pizda.ninka.net>
Date: Sun, 13 May 2001 19:53:52 -0700 (PDT)
To: Piotr Wysocki <wysek@tower.braxis.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5-pre1, iproute2 - IPv6
In-Reply-To: <Pine.LNX.4.33.0105140040010.2829-100000@tower.braxis.co.uk>
In-Reply-To: <Pine.LNX.4.33.0105140040010.2829-100000@tower.braxis.co.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Piotr Wysocki writes:
 > ll_proto.c:36: `ETH_P_ECHO' undeclared here (not in a function)
 > ll_proto.c:36: initializer element is not constant
 > ll_proto.c:36: (near initialization for `llproto_names[1].id')

Just simply remove references to these (bogus, that's why they were
removed from the kernel headers) ETH_* constants in the iproute
sources.

Alexey should be making a new release sometime soon now that he
is back.

Later,
David S. Miller
davem@redhat.com
