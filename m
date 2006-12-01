Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935379AbWLANDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935379AbWLANDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936486AbWLANDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:03:34 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52884 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S935379AbWLANDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:03:30 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 1 Dec 2006 08:00:11 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: how many "KERNEL" macro variations do we really need?
Message-ID: <Pine.LNX.4.64.0612010757430.1721@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, UPPERCASE_25_50 0.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  i'm sure there's a simpler way to write this:

include/linux/soundcard.h:
  #if (!defined(__KERNEL__) && !defined(KERNEL) && !defined(INKERNEL)  && !defined(_KERNEL)) ||
defined(USE_SEQ_MACROS)

__KERNEL__ versus KERNEL versus INKERNEL versus _KERNEL?  surely,
those can't *all* be necessary.  or can they?

rday


