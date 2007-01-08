Return-Path: <linux-kernel-owner+w=401wt.eu-S1161204AbXAHKZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbXAHKZz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161201AbXAHKZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:25:54 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:35238 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161204AbXAHKZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:25:53 -0500
X-Greylist: delayed 1552 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 05:25:53 EST
Date: Mon, 8 Jan 2007 10:59:57 +0100 (MET)
From: Jonas Svensson <jonass@lysator.liu.se>
To: linux-kernel@vger.kernel.org
Cc: Jonas Svensson <jonass@lysator.liu.se>
Subject: trouble loading self compiled vanilla kernel
Message-ID: <Pine.GSO.4.51L2.0701081054010.27141@nema.lysator.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have trouble booting a kernel I have compiled myself. I have changed
from FedoraCore 2 to CentOS 4.4 and is trying to compile my own kernel. In
FC2 I were able to compile and boot a custom kernel and this system boots
fine with the kernel supplied by CentOS. I want to compile my own to get
support for second head on Matrox G400DH (for tv out) and Hauppauge PVR150
(tv in). I downloaded kernel 2.6.19.1 from kernel.org and compiled it like
make mrproper, make menuconfig, make, make modules_install, make install.
I also tried doing make oldconfig using config from kernel supplied with
centos, also make default config and a kernel without modules support. I
even reinstalled CentOS 4.4 tried compiling the kernel first thing, to
make sure I did not mess up anything with alternative packages before.

All results in the same problem: the booting stops about when grub is
finished and the kernel should continue. I get the
message about loading initrd but not the line of "Uncompressing
Linux... Ok, booting the kernel". Instead I get a blank screen with a
flashing cursor at top left. Thats all, nothing more happens. Any
suggestions on what could be wrong or what I should do?

Hardware: Asus P3B-F (motherboard), Celeron 1.1GHz, Matrox G400DH and so
on.

Please keep the CC: jonass@lysator.liu.se

