Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVLWASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVLWASt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLWASt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:18:49 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:26541 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751213AbVLWASs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.14-rc6-git 0/6] SPI core, refresh
Date: Thu, 22 Dec 2005 15:36:50 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
References: <200511102355.11505.david-b@pacbell.net>
In-Reply-To: <200511102355.11505.david-b@pacbell.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512221536.50990.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had several requests recently for the latest standalone
version of these patches, so here it is:  six patches, posted
right after this message.  This is very close to what's in the
2.6.15-rc5-mm3 patches, modulo bitbang tweaks and more drivers.

In sequence:

  # core
  spi.patch

  # protocol drivers
  ads7846.patch
  dataflash.patch
  m25p80.patch

  # bitbang utilities
  bitbang_spi.patch

  # bitbang adapter (example)
  butterfly.patch

The new drivers are for M25P series SPI Flash, and a parport
adapter cable for a $20 AVR microcontroller board.

- Dave
