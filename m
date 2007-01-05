Return-Path: <linux-kernel-owner+w=401wt.eu-S1030357AbXAEHCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbXAEHCV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbXAEHCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:02:20 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:37424 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030360AbXAEHCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:02:18 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 5 Jan 2007 01:56:09 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
In-Reply-To: <20070105063600.GA13571@Ahmed>
Message-ID: <Pine.LNX.4.64.0701050154020.21674@localhost.localdomain>
References: <20070105063600.GA13571@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Ahmed S. Darwish wrote:

> Remove unnecessary kmalloc casts in drivers/char/tty_io.c

rather than remove these casts a file or two at a time, why not just
do them all at once and submit a single patch?  there aren't that many
of them:

  grep -Er "\([^\)\*]+\*\) ?k[cmz]alloc ?\(" .

rday
