Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVAGOCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVAGOCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 09:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVAGOCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 09:02:33 -0500
Received: from [212.20.225.142] ([212.20.225.142]:52286 "EHLO
	orlando.wolfsonmicro.main") by vger.kernel.org with ESMTP
	id S261419AbVAGOCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 09:02:24 -0500
Subject: [PATCH 0/5] WM97xx touch driver AC97 plugin
From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Vincent Sanders <vince@simtec.co.uk>, Ian Molton <spyro@f2s.com>,
       Andrew Zabolotny <zap@homelink.ru>
Content-Type: text/plain
Message-Id: <1105106543.9143.995.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 Jan 2005 14:02:23 +0000
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2005 14:02:23.0531 (UTC) FILETIME=[82E7C7B0:01C4F4C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch adds support for the WM97xx touchscreen controllers. Please
note this patch depends on the AC97 plugin suspend/resume patch posted
on 4/1/2005.

Patch is against 2.6.10 with the AC97 plugin suspend/resume patch.

Features:-

 - supports WM9705, WM9712, WM9713
 - polling mode
 - coordinate polling
 - continuous mode (arch-dependent)
 - adjustable rpu/dpp settings
 - adjustable pressure current
 - adjustable sample settle delay
 - 4 and 5 wire touchscreens (5 wire is WM9712 only)
 - pen down detection
 - battery monitor
 - sample AUX adc's
 - power management
 - codec GPIO
 - codec event notification (i.e. jack insertion)


Many thanks to Russell King, Vincent Sanders, Ian Molton and Andrew
Zabolotny for supplying patches, bug fixes and generally helping in the
development of the driver.

Liam

