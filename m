Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVCYWEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVCYWEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVCYWBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:01:46 -0500
Received: from box3.punkt.pl ([217.8.180.76]:35346 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261830AbVCYV7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:59:55 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.11.1
Date: Fri, 25 Mar 2005 22:58:35 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503252258.35477.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- small (but important) fix in netfilter
- added cleaned up mtd/* userland headers
- massive change to use types from linux/types.h and not to pollute the 
namespace
- use gcc emitted __mips64 instead of CONFIG_MIPS{32,64}

I've missed one change in netfilter_ipv4/ip_nat.h when doing 2.6.11.0 which 
resulted in broken builds of iptables (so I've been told). Well, these things 
might happen from time to time.

As to the last two changes, Erik Andersen provided a script that did them all. 
The __mips64 thing is really nice since it removes dependency from 
linux/config.h and still works as expected. Wonder if gcc emits other 
(potentially) usefull definitions...


Happy Easter.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
