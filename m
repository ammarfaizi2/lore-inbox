Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266063AbRGOLMX>; Sun, 15 Jul 2001 07:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbRGOLMN>; Sun, 15 Jul 2001 07:12:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7552 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266063AbRGOLL4>;
	Sun, 15 Jul 2001 07:11:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15185.31355.152129.716780@pizda.ninka.net>
Date: Sun, 15 Jul 2001 04:11:55 -0700 (PDT)
To: "George Bonser" <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Linux default IP ttl
In-Reply-To: <CHEKKPICCNOGICGMDODJOEEMDKAA.george@gator.com>
In-Reply-To: <15185.27251.356109.500135@pizda.ninka.net>
	<CHEKKPICCNOGICGMDODJOEEMDKAA.george@gator.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


George Bonser writes:
 > While it is still the wee hours ... 4am here ... the change in TTL has
 > resulted in a 10% increase in bandwidth to my server farms so far. It
 > appears to be a substantial improvement.

These people need to fix their systems and routes.

As it stands they have put themselves in a position where they cannot
reach any existing Linux system with a default ttl on routes that
exceed 64 hops.

I mean, even if I did change the default ttl, this would still leave
them with the problem for all existing sites.

Later,
David S. Miller
davem@redhat.com

