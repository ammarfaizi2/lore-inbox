Return-Path: <linux-kernel-owner+w=401wt.eu-S964795AbXADM2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbXADM2M (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 07:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbXADM2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 07:28:12 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:3982 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964795AbXADM2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 07:28:11 -0500
Date: Thu, 4 Jan 2007 13:28:06 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>
Subject: [GIT PULL] More i2c updates for 2.6.20
Message-Id: <20070104132806.79cf015e.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the i2c subsystem updates for Linux 2.6.20 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus

These are late fixes that I want to have in 2.6.20, fixing compilation
breakage of the new i2c-pnx bus driver, and helping compatibility
with regards to planned i2c-core cleanups.

 Documentation/feature-removal-schedule.txt |   17 +++++++++++++++++
 MAINTAINERS                                |    6 ++++++
 drivers/i2c/busses/Kconfig                 |    9 ---------
 drivers/i2c/busses/i2c-pnx.c               |    7 +------
 drivers/i2c/i2c-core.c                     |   28 ++++++++++++++++++++++++----
 5 files changed, 48 insertions(+), 19 deletions(-)

---------------

David Brownell:
      i2c: Migration aids for i2c_adapter.dev removal

Vitaly Wool:
      i2c-pnx: Fix interrupt handler, get rid of EARLY config option
      i2c-pnx: Add entry to MAINTAINERS

Thanks,
-- 
Jean Delvare
