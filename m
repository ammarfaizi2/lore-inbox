Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUILXjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUILXjp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 19:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUILXjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 19:39:45 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:3817 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S264113AbUILXhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 19:37:03 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][0/0] ide: sanitize DMA
Date: Mon, 13 Sep 2004 01:33:04 +0200
User-Agent: KMail/1.6.2
Cc: "Mikael Starvik" <mikael.starvik@axis.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409130133.04246.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patchkit simplifies IDE DMA handling and fixes few bugs in
a process. It requires "sanitize PIO" patchkit to be applied first.

Mikeal, please check changes to Etrax ide.c.

Erik, could you take a look at sgiioc4.c changes
(disk DMA fix in particular)?

Thanks,
Bartlomiej
