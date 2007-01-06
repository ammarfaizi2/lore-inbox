Return-Path: <linux-kernel-owner+w=401wt.eu-S1751349AbXAFLLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXAFLLk (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 06:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbXAFLLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 06:11:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53209 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbXAFLLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 06:11:39 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 6 Jan 2007 06:06:40 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: what means "init_hrtimer_#CLOCKTYPE()"?
Message-ID: <Pine.LNX.4.64.0701060602470.11492@localhost.localdomain>
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


  in include/linux/hrtimer.h, we read:

  * The hrtimer structure must be initialized by init_hrtimer_#CLOCKTYPE()

what means that last part, "init_hrtimer_#CLOCKTYPE()"?  i'm not aware
of any such routine.  i'm aware only of init_hrtimers_cpu().

rday

p.s.  besides, that "#" messes up the kernel-doc processing, anyway.
