Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVEVXyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVEVXyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 19:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEVXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 19:54:54 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:33924 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261828AbVEVXy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 19:54:27 -0400
Message-Id: <20050522235233.190143000@abc>
Date: Mon, 23 May 2005 01:52:33 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-SA-Exim-Connect-IP: 84.189.216.198
Subject: [DVB patch 0/5] DVB update, mostly dvb-usb
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here's another update for DVB. Two of the patches are
huge (sigh), one drops the dibusb driver, and the
other adds a generalized dvb-usb driver. Both dibusb
and dvb-usb were written by Patrick Boettcher, and
dvb-usb is a refactored version of the dibusb driver,
extended to support a whole zoo of devices.
Unforunately the dvb-usb patch comes with some
incompatible changes to the dibcom frontend drivers,
so we can't have both the dibusb and the dvb-usb drivers.

The dvb-usb driver has been in CVS for more than a
month and is considered stable by its author.

The two big patches probably exceed the mailing list
limit and are also available here:
http://linuxtv.org/downloads/patches/2.6.12-rc4-3/quilt/dvb-remove-dibusb-driver.patch
http://linuxtv.org/downloads/patches/2.6.12-rc4-3/quilt/dvb-add-dvb-usb-driver.patch

Please apply.

Thanks,
Johannes

