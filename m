Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVAEC3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVAEC3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVAEC13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:27:29 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:28341 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262209AbVAECYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:24:30 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022449.22297.54853.67329@localhost.localdomain>
Subject: [PATCH 0/3] sh64: remove cli()/sti() from arch/sh64/*
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:24:29 -0600
Date: Tue, 4 Jan 2005 20:24:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try this again - this time with sequence numbers.

This series of patches is to remove the last cli()/sti() function calls in arch/sh64.

These are the only instances in active code that grep could find.

 kernel/time.c     |    4 ++--
 mach-cayman/irq.c |    8 ++++----
 mm/fault.c        |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
