Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVADWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVADWgn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVADWfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:35:24 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:57260 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S262123AbVADWdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:33:09 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc: ralf@linux-mips.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104223327.21889.11863.64754@localhost.localdomain>
Subject: [PATCH 0/4] mips: remove cli()/sti() from arch/mips/*
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 16:33:07 -0600
Date: Tue, 4 Jan 2005 16:33:07 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the last cli()/sti() function calls in arch/mips.

These are the only instances in active code that grep could find.

 gt64120/ev64120/irq.c                            |    2 +-
 jmr3927/rbhma3100/setup.c                        |    2 +-
 tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c   |    2 +-
 tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)
