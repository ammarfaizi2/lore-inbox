Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSJZU4O>; Sat, 26 Oct 2002 16:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbSJZU4O>; Sat, 26 Oct 2002 16:56:14 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:24651 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261520AbSJZU4N>; Sat, 26 Oct 2002 16:56:13 -0400
Subject: AX.25 in 2.5.43
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1035666228.1504.7.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 26 Oct 2002 17:03:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't tried this in 2.5.44 yet.   I am just beginning to play with
this myself.  Has this been fixed or should I dig into it?

net/ipv4/arp.c:104:22: net/ax25.h: No such file or directory
net/ipv4/arp.c: In function `arp_send':
net/ipv4/arp.c:551: `AX25_P_IP' undeclared (first use in this function)
net/ipv4/arp.c:551: (Each undeclared identifier is reported only once
net/ipv4/arp.c:551: for each function it appears in.)
net/ipv4/arp.c: In function `arp_process':
net/ipv4/arp.c:670: `AX25_P_IP' undeclared (first use in this function)
make[2]: *** [net/ipv4/arp.o] Error 1
make[1]: *** [net/ipv4] Error 2


