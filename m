Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423152AbWJRXh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423152AbWJRXh7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423154AbWJRXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:37:59 -0400
Received: from [63.64.152.142] ([63.64.152.142]:49166 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1423152AbWJRXh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:37:58 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 0/7] drivers/dma & I/OAT fixes
Date: Wed, 18 Oct 2006 16:44:17 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, akpm@osdl.org,
       jeff@garzik.org
Message-Id: <20061018234417.26671.56773.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various fixes for the hardware memcpy engine code and ioatdma

Most of these I've posted before, except for the patch to handle sysfs
errors from Jeff Garzik.  I've dropped the controversial change to not
offload loopback traffic.

These changes can be pulled from
	git://lost.foo-projects.org/~cleech/linux-2.6 master

--
Chris Leech <christopher.leech@intel.com>
I/O Acceleration Technology Software Development
LAN Access Division / Digital Enterprise Group 
