Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTELDCl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbTELDCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:02:41 -0400
Received: from havoc.daloft.com ([64.213.145.173]:17069 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261852AbTELDCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:02:39 -0400
Date: Sun, 11 May 2003 23:15:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK+PATCH] net driver irqreturn_t
Message-ID: <20030512031522.GA27077@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

Others may download

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk6-netdrvr2.bz2

This will update the following files:

 drivers/net/apne.c                  |    9 +++++----
 drivers/net/arcnet/arcnet.c         |    5 +++--
 drivers/net/fc/iph5526.c            |   18 ++++++++++--------
 drivers/net/fec.c                   |   18 +++++++++++++-----
 drivers/net/fmv18x.c                |    6 +++---
 drivers/net/hamradio/scc.c          |    7 ++++---
 drivers/net/irda/sa1100_ir.c        |    3 ++-
 drivers/net/macmace.c               |    5 +++--
 drivers/net/myri_sbus.c             |    4 +++-
 drivers/net/seeq8005.c              |    9 +++++++--
 drivers/net/sun3lance.c             |    8 ++++----
 drivers/net/sunqe.c                 |    1 +
 drivers/net/tokenring/lanstreamer.c |    5 +++--
 drivers/net/tulip/de4x5.c           |    2 +-
 drivers/net/wan/lmc/lmc_main.c      |    8 ++++++--
 include/linux/arcdevice.h           |    2 +-
 16 files changed, 69 insertions(+), 41 deletions(-)

through these ChangeSets:

<akpm@digeo.com> (03/05/11 1.1088)
   [netdrvr] remaining irqreturn_t changes

