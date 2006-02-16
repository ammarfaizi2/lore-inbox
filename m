Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWBPFoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWBPFoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 00:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWBPFoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 00:44:18 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:63717 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932481AbWBPFoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 00:44:17 -0500
Subject: SATA timeouts with Seagate disk on VIA VT6420 controller
From: Nicholas Miell <nmiell@comcast.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 21:44:14 -0800
Message-Id: <1140068654.3274.12.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From time to time, I've been experiencing timeouts with my SATA disk (a
Seagate ST3300831AS) attached to a VIA VT6420 controller on a VIA
K8T800-based MSI motherboard. This has happened somewhat rarely on a
variety of Fedora kernel versions.

Basically, sometimes IO will get really slow and I'll start getting
"ata1: command 0x35 timeout, stat 0x50 host_stat 0x4" in my logs, with
the occasional "ata1: command 0x25 timeout, stat 0x50 host_stat 0x4" and
"ata1: command 0xb0 timeout, stat 0x50 host_stat 0x0" thrown in for good
measure.

The disk (and/or controller) isn't unresponsive -- I can do a smartctl
-a -d ata /dev/sda and it'll complete (eventually), and IO to the disk
continues (very slowly), but it's generally unusable until the next
reboot.

Any help would be appreciated.

	Thanks, Nicholas.

-- 
Nicholas Miell <nmiell@comcast.net>

