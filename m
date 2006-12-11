Return-Path: <linux-kernel-owner+w=401wt.eu-S1762842AbWLKLp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762842AbWLKLp6 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 06:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762843AbWLKLp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 06:45:57 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:39325 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762842AbWLKLp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 06:45:57 -0500
Message-ID: <457D44EC.3090202@drzeus.cx>
Date: Mon, 11 Dec 2006 12:45:48 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MMC updates
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

        git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git for-linus

to receive the following updates:

 drivers/mmc/at91_mci.c  |  346 +++++++++++++++++++++++++----------------------
 drivers/mmc/mmc_queue.c |    4 -
 drivers/mmc/sdhci.c     |    4 -
 3 files changed, 190 insertions(+), 164 deletions(-)

Andrew Victor:
      AT91 MMC 1: Pass host structure.
      AT91 MMC 2 : Use platform resources
      AT91 MMC 3 : Move global mci_clk variable
      AT91 MMC 4 : Interrupt handler cleanup
      AT91 MMC 5 : Minor cleanups
      AT91 MMC update for 2.6.19

Pierre Ossman:
      mmc: Change SDHCI iomem error to a warning

Vitaly Wool:
      mmc: fix "prev->state: 2 != TASK_RUNNING??" problem on SD/MMC  card removal


-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
