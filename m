Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263020AbTDBOvv>; Wed, 2 Apr 2003 09:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263021AbTDBOvv>; Wed, 2 Apr 2003 09:51:51 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:32387 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S263020AbTDBOve>; Wed, 2 Apr 2003 09:51:34 -0500
Date: Wed, 2 Apr 2003 17:02:54 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: my linux does not accept redirects
Message-ID: <Pine.LNX.4.51.0304021657090.2465@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are 2 routers on my network.
Router A routes to other internal networks
Router B routes to the Internet

My box has A as the default gateway.
It should get redirects for the Internet hosts and it does.
But despite icmp redirects are not filtered and
/proc/sys/net/ipv4/conf/eth1/accept_redirects is 1 it does not learn
the paths and i simply get flooded by the router with redirects about
every single packet that is sent.

What could be wrong?

Regards,
Maciej Soltysiak
