Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbQJaETL>; Mon, 30 Oct 2000 23:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbQJaETB>; Mon, 30 Oct 2000 23:19:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35969 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130152AbQJaESw>;
	Mon, 30 Oct 2000 23:18:52 -0500
Date: Mon, 30 Oct 2000 20:04:34 -0800
Message-Id: <200010310404.UAA05392@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: caperry@edolnx.net
CC: linux-kernel@vger.kernel.org
In-Reply-To: <39FE5C09.F1B13725@edolnx.net> (message from Carl Perry on Mon,
	30 Oct 2000 23:43:37 -0600)
Subject: Re: Is IPv4 totally broken in 2.4-test
In-Reply-To: <39FE5C09.F1B13725@edolnx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


echo "0" >/proc/sys/net/ipv4/tcp_ecn

Or don't enable CONFIG_INET_ECN in your kernel configuration.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
