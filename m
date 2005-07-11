Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVGKW4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVGKW4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVGKWNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:13:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:32476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262841AbVGKWDK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:10 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: max6875 Kconfig update
In-Reply-To: <11211193761992@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:56 -0700
Message-Id: <11211193763938@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: max6875 Kconfig update

Here is a proposed Kconfig update for the new max6875 i2c chip driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2146fec20c38d926f0d88413977f941f42a14588
tree daaf87a4ec6e6c70c9e1be8b2bd09257b3be092f
parent 089bd86632769051f15cd7387eebe126d18f151f
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 23:41:39 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/Kconfig |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -519,13 +519,16 @@ config SENSORS_M41T00
 	  will be called m41t00.
 
 config SENSORS_MAX6875
-	tristate "MAXIM MAX6875 Power supply supervisor"
+	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on I2C && EXPERIMENTAL
 	help
-	  If you say yes here you get support for the MAX6875
-	  EEPROM-Programmable, Hex/Quad, Power-Suppy Sequencers/Supervisors.
+	  If you say yes here you get support for the Maxim MAX6875
+	  EEPROM-programmable, quad power-supply sequencer/supervisor.
 
-          This provides a interface to program the EEPROM and reset the chip.
+	  This provides an interface to program the EEPROM and reset the chip.
+
+	  This driver also supports the Maxim MAX6874 hex power-supply
+	  sequencer/supervisor if found at a compatible address.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.

