Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269675AbTGJW4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269676AbTGJW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:56:17 -0400
Received: from smtp1.libero.it ([193.70.192.51]:8839 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S269675AbTGJW4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:56:15 -0400
Subject: [PATCH] LIRC drivers for 2.5.74 - 2nd version
From: Flameeyes <dgp85@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1057878716.24943.19.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 01:11:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here (http://flameeyes.web.ctonet.it/patch-2.5.74-lirc.diff.bz2) there
is the second version of my patch that adds the LIRC
(http://lirc.sf.net/) drivers to 2.5 kernels (this patch was prepared
using 2.5.74 kernel, but it should work also with earlier kernels).

In this version I removed the lirc_i2c driver that need the i2c driver
code from lm_sensors, and therefor is not compatible with 2.5 (I don't
know how to make it works sorry).
I also corrected the Makefile as told me by Boszormenyi Zoltan, and also
merged his patch for MOD_[INC|DEC]_USE_COUNT.

Please note that I'm not a lirc developer, I only took the cvs of lirc,
looked at the drivers dir and fixed the code to be compiled in the
kernel tree for 2.5.

The userland utilities remain the one from lirc package, to build them
you need the to use a valid 2.4 kernel tree.

-- 
Flameeyes <dgp85@users.sourceforge.net>

