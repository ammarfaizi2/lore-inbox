Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUHBVct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUHBVct (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUHBVcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:32:48 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:52634 "EHLO
	mailfe02.swip.net") by vger.kernel.org with ESMTP id S263740AbUHBVcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:32:46 -0400
X-T2-Posting-ID: mzHRUpvOlCbvaGn327Befg==
Date: Mon, 2 Aug 2004 23:33:09 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Subject: pci power management
Message-ID: <20040802213309.GA28580@linux.nu>
Reply-To: erik@rigtorp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the kernel should put every unclaimed device on the pci bus into
D3cold state. It can then be reactivated when a module is loaded. All pci
drivers should also put any device it has claimed into D3 if it is unloaded.

Erik
