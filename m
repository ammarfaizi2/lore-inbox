Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262497AbTCIL7e>; Sun, 9 Mar 2003 06:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262499AbTCIL7e>; Sun, 9 Mar 2003 06:59:34 -0500
Received: from quechua.inka.de ([193.197.184.2]:53395 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S262497AbTCIL7d>;
	Sun, 9 Mar 2003 06:59:33 -0500
To: linux-kernel@vger.kernel.org
Subject: deadlock in 2.5.64 ppp?
Date: Sun, 9 Mar 2003 12:13:52 +0100
Message-Id: <20030309111352.B013320EB5@dungeon.inka.de>
From: aj@dungeon.inka.de (Andreas Jellinghaus)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.5.64 vm I need to reboot my machines after a few days.
My laptop works fine, my server/gateway deadlocks when the
shutdown kills several processes.

The gateway has an older processor (p2 vs. p3), some additional
netfilter stuff, ipv6 support (unused), and ppp with pppoe
and a different network card (rtl8139). So I guess it might
be the pppoe stuff causing the trouble.

How can I find out more about it? ctrl-sysreq lists
all processes and several are in __down stuff. Would it
be usefull to write down that notes and mail it to l-k?
Or is it possible to dump that to a file? 

Andreas
