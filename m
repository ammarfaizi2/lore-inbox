Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbTICHLo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTICHLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:11:43 -0400
Received: from news.cistron.nl ([62.216.30.38]:55818 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261481AbTICHLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:11:42 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Date: Wed, 3 Sep 2003 07:11:40 +0000 (UTC)
Organization: Cistron
Message-ID: <bj447c$el6$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1062573100 15014 62.216.30.38 (3 Sep 2003 07:11:40 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says all! :-)

2.6.0-test3-mm2 still works (as does 2.4.21-rc2).

vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to work.
No kernel panics, it just doesn't work :-(


Both have same ethernet driver:

via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT6102 Rhine-II at 0xe800, 00:40:63:ca:6a:c1, IRQ 10.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.

Even manual config (normal is dhcp) doesn't work.

Haven't seen anyone else report this, but this is repeatable and i suspect
more people must have experienced this ?!

Machine is running debian-unstable distro.

Danny

-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

