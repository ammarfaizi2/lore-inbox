Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKOPox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 10:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKOPox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 10:44:53 -0500
Received: from [200.57.38.4] ([200.57.38.4]:32426 "EHLO gateway.mailvault.com")
	by vger.kernel.org with ESMTP id S261793AbTKOPow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 10:44:52 -0500
Date: Sat, 15 Nov 2003 16:40:19 00100 (CET)
To: linux-kernel@vger.kernel.org
From: "Job 317" <job317@mailvault.com>
Subject: 2.4.22 SMP kernel build for hyper threading P4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary = "=_758da3227574102e1163e77c45498608"
Message-Id: <20031115153950.41EB38407D1@gateway.mailvault.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encoded message.

--=_758da3227574102e1163e77c45498608
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alles,

I have a new P4 Hyperthreading PC that I have installed RedHat9 on. I am
trying to add some features to my kernel (e.g. NTFS read support, crypto
api, etc.) but when I build my new 2.4.22 kernel with CONFIG_SMP=y set
then reboot, I am seeing only one processor in /proc/cpuinfo. When I
boot with my stock RH9 2.4.20-20.9smp kernel I see two virtual
processors show up in /proc/cpuinfo.

I've even build a 2.4.22 kernel with the config-2.4.20-20.9smp
configuration that came with RH9.

I build with the straightforward 'make dep clean bzImage modules
modules_install' command. Is this correct?

Am I missing a step to build a smp kernel for hyper threading?

Your help would be most appreciated.

Job
--=_758da3227574102e1163e77c45498608--


