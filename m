Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWEGL3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWEGL3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 07:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWEGL3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 07:29:35 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:36264
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932124AbWEGL3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 07:29:34 -0400
X-Mailbox-Line: From mb@pc1 Sun May  7 13:36:04 2006
Message-Id: <20060507113513.418451000@pc1>
Date: Sun, 07 May 2006 13:35:13 +0200
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@plexity.net>, mbuesch@freenet.de,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: [patch 0/6] New Generic HW RNG
From: Michael Buesch <mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series replaces the old non-generic Hardware Random Number Generator support by a fully generic RNG API.

This makes it possible to register additional RNGs from modules. With this patch series applied, Laptops with
a bcm43xx chip (PowerBook) have a HW RNG available now.

Additionally two new RNG drivers are added for the "ixp4xx" and "omap" devices. (Written by Deepak Saxena).
This patch series includes the old patches by Deepak Saxena.

The x86-rng driver is the old RNG driver ported to the new API (and cleaned up a bit).

Please apply to -mm for testing.

