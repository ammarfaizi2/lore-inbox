Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVF0VdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVF0VdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVF0Vbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:31:33 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:6662 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261775AbVF0VaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:30:22 -0400
Date: Mon, 27 Jun 2005 23:30:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Moving hardware monitoring drivers to drivers/hwmon (3/3)
Message-Id: <20050627233029.59b226d9.khali@linux-fr.org>
In-Reply-To: <20050627224003.4b1ce717.khali@linux-fr.org>
References: <20050627224003.4b1ce717.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Finally this third patch moves the hardware monitoring drivers
documentation files from Documentation/i2c/chips to Documentation/hwmon,
as well the sysfs-interface and userspace-tools documentation files from
Documentation/i2c to Documentation/hwmon.

Again, this patch being large (267 kB) and uninteresting, I'm not
including it, you can get it here:

http://jdelvare.net1.nerim.net/sensors/linux-2.6.12-git5-hwmon-move-all-drivers-3-doc.diff.gz

 Documentation/hwmon/adm1021         |  111 +++++++++
 Documentation/hwmon/adm1025         |   51 ++++
 Documentation/hwmon/adm1026         |   93 ++++++++
 Documentation/hwmon/adm1031         |   35 +++
 Documentation/hwmon/adm9240         |  177 +++++++++++++++
 Documentation/hwmon/asb100          |   72 ++++++
 Documentation/hwmon/ds1621          |  108 +++++++++
 Documentation/hwmon/fscher          |  169 +++++++++++++++
 Documentation/hwmon/gl518sm         |   74 ++++++
 Documentation/hwmon/it87            |   96 ++++++++
 Documentation/hwmon/lm63            |   57 +++++
 Documentation/hwmon/lm75            |   65 +++++
 Documentation/hwmon/lm77            |   22 +
 Documentation/hwmon/lm78            |   82 +++++++
 Documentation/hwmon/lm80            |   56 +++++
 Documentation/hwmon/lm83            |   76 ++++++
 Documentation/hwmon/lm85            |  221 +++++++++++++++++++
 Documentation/hwmon/lm87            |   73 ++++++
 Documentation/hwmon/lm90            |  121 ++++++++++
 Documentation/hwmon/lm92            |   37 +++
 Documentation/hwmon/max1619         |   29 ++
 Documentation/hwmon/pc87360         |  189 ++++++++++++++++
 Documentation/hwmon/sis5595         |  106 +++++++++
 Documentation/hwmon/smsc47b397      |  158 ++++++++++++++
 Documentation/hwmon/smsc47m1        |   52 ++++
 Documentation/hwmon/sysfs-interface |  274 ++++++++++++++++++++++++
 Documentation/hwmon/userspace-tools |   39 +++
 Documentation/hwmon/via686a         |   65 +++++
 Documentation/hwmon/w83627hf        |   66 +++++
 Documentation/hwmon/w83781d         |  402 ++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/w83l785ts       |   39 +++
 Documentation/i2c/chips/adm1021     |  111 ---------
 Documentation/i2c/chips/adm1025     |   51 ----
 Documentation/i2c/chips/adm1026     |   93 --------
 Documentation/i2c/chips/adm1031     |   35 ---
 Documentation/i2c/chips/adm9240     |  177 ---------------
 Documentation/i2c/chips/asb100      |   72 ------
 Documentation/i2c/chips/ds1621      |  108 ---------
 Documentation/i2c/chips/fscher      |  169 ---------------
 Documentation/i2c/chips/gl518sm     |   74 ------
 Documentation/i2c/chips/it87        |   96 --------
 Documentation/i2c/chips/lm63        |   57 -----
 Documentation/i2c/chips/lm75        |   65 -----
 Documentation/i2c/chips/lm77        |   22 -
 Documentation/i2c/chips/lm78        |   82 -------
 Documentation/i2c/chips/lm80        |   56 -----
 Documentation/i2c/chips/lm83        |   76 ------
 Documentation/i2c/chips/lm85        |  221 -------------------
 Documentation/i2c/chips/lm87        |   73 ------
 Documentation/i2c/chips/lm90        |  121 ----------
 Documentation/i2c/chips/lm92        |   37 ---
 Documentation/i2c/chips/max1619     |   29 --
 Documentation/i2c/chips/pc87360     |  189 ----------------
 Documentation/i2c/chips/sis5595     |  106 ---------
 Documentation/i2c/chips/smsc47b397  |  158 --------------
 Documentation/i2c/chips/smsc47m1    |   52 ----
 Documentation/i2c/chips/via686a     |   65 -----
 Documentation/i2c/chips/w83627hf    |   66 -----
 Documentation/i2c/chips/w83781d     |  402 ------------------------------------
 Documentation/i2c/chips/w83l785ts   |   39 ---
 Documentation/i2c/sysfs-interface   |  274 ------------------------
 Documentation/i2c/userspace-tools   |   39 ---
 62 files changed, 3215 insertions(+), 3215 deletions(-)


Thanks,
-- 
Jean Delvare
