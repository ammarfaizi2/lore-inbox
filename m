Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbQLMT6g>; Wed, 13 Dec 2000 14:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbQLMT60>; Wed, 13 Dec 2000 14:58:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5760 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130030AbQLMT6Q>;
	Wed, 13 Dec 2000 14:58:16 -0500
Date: Wed, 13 Dec 2000 11:11:35 -0800
Message-Id: <200012131911.LAA01863@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: pete@research.netsol.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20001213141715.K1139@tesla.admin.cto.netsol.com> (message from
	Pete Toscano on Wed, 13 Dec 2000 14:17:15 -0500)
Subject: Re: test1[12] + sparc + bind 9.1.0b1 == bad things
In-Reply-To: <20001213141715.K1139@tesla.admin.cto.netsol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 13 Dec 2000 14:17:15 -0500
   From: Pete Toscano <pete@research.netsol.com>

   i'm tried using the first beta release of bind 9.1.0 on an ultra 5
   running 2.4.0-test11 or test12 (modified redhat 6.2 distro -- mostly
   ipv6-related mods).  as soon as i start up named, the machine goes nuts
   and continuously prints the following oops (from test12):

Is this the first OOPS it prints out?  I don't think so.  I am
very sure it printed out messages from die_if_kernel first and
we need that initial OOPS to diagnose this bug and fix it.

All the rest of the OOPS messages are useless and won't tell
us what the real problem is.

Later,
David S. Miller
Davem@Redhat.Com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
