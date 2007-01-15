Return-Path: <linux-kernel-owner+w=401wt.eu-S932245AbXAOLnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbXAOLnG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbXAOLnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:43:06 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:47625 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbXAOLnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:43:05 -0500
X-Originating-Ip: 74.109.98.130
Date: Mon, 15 Jan 2007 06:18:30 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Another potential kbuild cleanup -- "def_boolean"
Message-ID: <Pine.LNX.4.64.0701150615230.1768@CPE00045a9c397f-CM001225dbafb6>
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


  while the kconfig parser recognizes both "def_bool" and
"def_boolean", apparently no one uses the longer form, so it's
probably safe to toss if there are no plans to use it in the future.

rday
