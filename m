Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbUKLPCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUKLPCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbUKLPCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:02:05 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:37511 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262540AbUKLPCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:02:02 -0500
Date: Fri, 12 Nov 2004 15:02:01 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial docfix i2c
Message-ID: <20041112150201.GA20007@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Pur linux-2.6.8.1/Documentation/i2c/dev-interface linux-2.6.8.1-patched/Documentation/i2c/dev-interface
--- linux-2.6.8.1/Documentation/i2c/dev-interface	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1-patched/Documentation/i2c/dev-interface	2004-11-12 15:55:40.703334026 +0100
@@ -3,7 +3,7 @@
 the /dev interface. You need to load module i2c-dev for this.
 
 Each registered i2c adapter gets a number, counting from 0. You can
-examine /proc/bus/i2c to see what number corresponds to which adapter.
+examine /sys/bus/i2c to see what number corresponds to which adapter.
 I2C device files are character device files with major device number 89
 and a minor device number corresponding to the number assigned as 
 explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
@@ -19,7 +19,7 @@
 knows about i2c, there is not much choice.
 
 Now, you have to decide which adapter you want to access. You should
-inspect /proc/bus/i2c to decide this. Adapter numbers are assigned
+inspect /sys/bus/i2c to decide this. Adapter numbers are assigned
 somewhat dynamically, so you can not even assume /dev/i2c-0 is the
 first adapter.
 
