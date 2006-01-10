Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWAJUZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWAJUZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWAJUZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:25:14 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:3743
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932586AbWAJUZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:25:12 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Subject: [drivers/block/ps2esdi.o] Error 1
Date: Tue, 10 Jan 2006 14:25:14 -0600
Message-Id: <20060110202300.M85828@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.90.18.24 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While building the Linus-git tree I got some errors. I Updated the last time
at 1:PM EST

  LD      drivers/base/built-in.o
  CC      drivers/block/floppy.o
  CC      drivers/block/loop.o
  CC      drivers/block/ps2esdi.o
In file included from drivers/block/ps2esdi.c:42:
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please move
your driver to the new sysfs api"
drivers/block/ps2esdi.c: In function 'ps2esdi_getgeo':
drivers/block/ps2esdi.c:1064: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:1065: error: dereferencing pointer to incomplete type
drivers/block/ps2esdi.c:1066: error: dereferencing pointer to incomplete type
make[3]: *** [drivers/block/ps2esdi.o] Error 1
make[2]: *** [drivers/block] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/root/linux-2.6'
make: *** [debian/stamp-build-kernel] Error 2

.Alejandro
