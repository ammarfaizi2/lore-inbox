Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWJ3HKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWJ3HKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 02:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWJ3HKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 02:10:38 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:41707 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1161161AbWJ3HKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 02:10:38 -0500
Message-ID: <4545A55F.2090807@cateee.net>
Date: Mon, 30 Oct 2006 08:10:23 +0100
From: Giacomo Catenazzi <cate@cateee.net>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: compiling error: WARNING: "mii_nway_restart" [drivers/usb/net/usbnet.ko]
 undefined!
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the git of yesterday (2.6.19-rc3-g7a20655b, but with changed
config), I have this error:

Kernel: arch/i386/boot/bzImage is ready  (#114)
  Building modules, stage 2.
  MODPOST 98 modules
WARNING: "mii_nway_restart" [drivers/usb/net/usbnet.ko] undefined!
WARNING: "mii_link_ok" [drivers/usb/net/usbnet.ko] undefined!
WARNING: "mii_ethtool_sset" [drivers/usb/net/usbnet.ko] undefined!
WARNING: "mii_ethtool_gset" [drivers/usb/net/usbnet.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

ciao
	cate
