Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTH1KIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbTH1KHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:07:42 -0400
Received: from vwisb7.vkw.tu-dresden.de ([141.30.51.183]:42427 "EHLO
	vwisb7.vkw.tu-dresden.de") by vger.kernel.org with ESMTP
	id S263832AbTH1Jdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 05:33:42 -0400
Date: Thu, 28 Aug 2003 11:33:39 +0200
From: Torsten Werner <email@twerner42.de>
To: linux-kernel@vger.kernel.org
Subject: PCI class problem (Promise SuperTrak SX6000)
Message-ID: <20030828093339.GA17974@vwisb7.vkw.tu-dresden.de>
Mail-Followup-To: Torsten Werner <email@twerner42.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.21 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with a Promise SX6000 IDE-RAID adapter on a Tyan Tiger
MPX mainboard. lspci does not detect the I2O device class but an unknown
ff00 device class:

00:09.0 PCI bridge: Intel Corp. 80960RM [i960RM Bridge] (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64

00:09.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02) (prog-if 01)
	Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
	Flags: bus master, medium devsel, latency 64, IRQ 17
	Memory at f6400000 (32-bit, prefetchable) [size=4M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

Of course the i2o driver does not find any i2o adapter. What may be
wrong here? Please Cc: any answers to me because I am not subscribed to
linux-kernel.

Thanks,
Torsten

-- 
Torsten Werner                         Dresden University of Technology
email@twerner42.de                   +49 351 46336711 / +49 162 3123004
http://www.twerner42.de/                      telefax: +49 351 46336809

