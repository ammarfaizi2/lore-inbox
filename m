Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVA0Xuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVA0Xuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVA0XuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:50:21 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:20943 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261293AbVA0Xa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:30:58 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cristoph@lameter.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050127233053.23569.16444.60993@localhost.localdomain>
Subject: [PATCH 0/8] pcxx: Remove obsolete driver
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 17:30:54 -0600
Date: Thu, 27 Jan 2005 17:30:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is to remove the pcxx driver.  It is obsoleted by the epca
driver.

These patches go together.

Diffstat:
 MAINTAINERS              |    7
 drivers/char/Kconfig     |   17
 drivers/char/Makefile    |    1
 drivers/char/digi_bios.h |  177 ---
 drivers/char/digi_fep.h  |  517 ----------
 drivers/char/fep.h       |  168 ---
 drivers/char/pcxx.c      | 2353 -----------------------------------------------
 drivers/char/pcxx.h      |  128 --
 8 files changed, 3368 deletions(-)
