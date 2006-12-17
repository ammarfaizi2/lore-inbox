Return-Path: <linux-kernel-owner+w=401wt.eu-S1752399AbWLQKwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbWLQKwv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbWLQKwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:52:51 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:55897 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbWLQKwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:52:51 -0500
X-Originating-Ip: 24.148.236.183
Date: Sun, 17 Dec 2006 05:47:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: error: 'struct work_struct' has no member named 'management'
Message-ID: <Pine.LNX.4.64.0612170544300.17584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	timed out)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  CC      drivers/connector/connector.o
drivers/connector/connector.c: In function 'cn_call_callback':
drivers/connector/connector.c:138: error: 'struct work_struct' has no member named 'management'
drivers/connector/connector.c:138: error: 'struct work_struct' has no member named 'management'
make[2]: *** [drivers/connector/connector.o] Error 1
make[1]: *** [drivers/connector] Error 2
make: *** [drivers] Error 2

  this is with the latest pull from the repo and "make allyesconfig".

rday

