Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVCEUUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVCEUUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVCEUSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:18:18 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21689 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261237AbVCEUFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:05:40 -0500
Subject: Unsupported PM cap regs version 1
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 05 Mar 2005 15:05:35 -0500
Message-Id: <1110053135.12513.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I load the driver for my SBLive Platinum I get this log
message:

PCI: 0000:00:0f.0 has unsupported PM cap regs version (1)

even though CONFIG_PM is not set.

I see that this issue came up in January on LKML but there was no
resolution.

First, why don't we support PM cap regs versions other than 2?  Second,
why is this printk() necessary?  If we really don't support older
versions for a good reason, do we really need to constantly remind the
user about it?  Especially if power management is disabled?

The overall effect is to give the user the impression that the hardware
is somehow broken.

Lee

