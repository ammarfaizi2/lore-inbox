Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTC3VTY>; Sun, 30 Mar 2003 16:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbTC3VTY>; Sun, 30 Mar 2003 16:19:24 -0500
Received: from imsp210.netvigator.com ([203.198.23.213]:48618 "EHLO
	imsp210.netvigator.com") by vger.kernel.org with ESMTP
	id <S261294AbTC3VTW>; Sun, 30 Mar 2003 16:19:22 -0500
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre6 modules can't access kernel symbols - build system problem?
Date: Mon, 31 Mar 2003 05:29:18 +0800
User-Agent: KMail/1.5
X-OS: GNU/Linux 2.4.21-pre5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303310529.18782.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encounter a problem which baffles me, having built same release before

1) Checked 21-pre6 out from local BK tree

2) Patched with latest acpi and win4lin

3) make oldconfig

4) Made some config changes

5) make dep, bzImage, modules - use gcc295

6) Compiled w/o any problem

7) installed and reboot, cant load _any_ (0) modules

depmod reports missing symbols in all modules

For example modprobe 8390 reports unresolved symbols including: enable_irq, kmalloc, printk,disable_irq

*** It seems kernel symbols cant be accessed by modules

8) I rebuild all after making clean, same result


Where do I go wrong?

I can send complete build logs upon request.


Regards
Michael
