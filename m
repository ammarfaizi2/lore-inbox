Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935423AbWKZPTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935423AbWKZPTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935425AbWKZPTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 10:19:55 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:3794 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935423AbWKZPTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 10:19:55 -0500
X-Originating-Ip: 72.57.81.197
Date: Sun, 26 Nov 2006 10:16:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: more pedantry:  "depends on" versus "depends" versus "requires"
Message-ID: <Pine.LNX.4.64.0611261013230.26218@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i'm thinking that the kconfig structure doesn't really need to
support all three of these dependency directives for Kconfig files.  a
quick occurrence count:

  "depends on":	4421
  "depends":	45
  "requires":	0

  under the circumstances, why not just standardize on "depends on"
everywhere and remove the obvious redundancy from the scripts/kconfig/
parser files?

rday
