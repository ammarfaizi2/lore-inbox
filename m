Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVAECXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVAECXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVAECXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:23:00 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:31929 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262191AbVAECWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:22:53 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022304.22296.7672.51691@localhost.localdomain>
Subject: [PATCH /3] sh64: remove cli()/sti() from arch/sh64/*
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:22:44 -0600
Date: Tue, 4 Jan 2005 20:22:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the last cli()/sti() function calls in arch/sh64.

These are the only instances in active code that grep could find.

 kernel/time.c     |    4 ++--
 mach-cayman/irq.c |    8 ++++----
 mm/fault.c        |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)
