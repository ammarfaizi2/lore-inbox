Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUKOVPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUKOVPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKOVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:13:51 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:38859 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261714AbUKOVMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:12:40 -0500
Date: Mon, 15 Nov 2004 22:12:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
Subject: early printk activated?
Message-ID: <Pine.LNX.4.53.0411152211110.8721@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


menuconfig says this for CONFIG_EARLY_PRINTK:
  |                                                                         |
  | Write kernel log output directly into the VGA buffer or to a serial     |
  | port.                                                                   |
  |                                                                         |
  | This is useful for kernel debugging when your machine crashes very      |
  | early before the console code is initialized. For normal operation      |
  | it is not recommended because it looks ugly and doesn't cooperate       |
  | with klogd/syslogd or the X server. You should normally N here,         |
  | unless you want to debug such a crash.                                  |

So, why then is it default if it should better be N?
(Fresh vanilla linux-2.6.9.tar.bz2 tree from kernel.org)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
